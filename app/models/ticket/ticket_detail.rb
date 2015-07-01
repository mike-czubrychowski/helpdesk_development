class TicketDetail < ActiveRecord::Base

  include ActiveModel::Dirty
  #require 'date' 

  

  belongs_to :location,																  				inverse_of: :ticket_details
  belongs_to :parent,   				class_name: "TicketDetail",                             	inverse_of: :children
  has_many 	 :children,   			class_name: "TicketDetail",              foreign_key: "parent_id", 	inverse_of: :parent  
  belongs_to :ticket_category, 				 class_name: "TicketCategory",     foreign_key: "ticket_category_id", 							  	inverse_of: :ticket_details	
  belongs_to :ticket_status, 					 class_name: "TicketStatus",       foreign_key: "ticket_status_id", 								inverse_of: :ticket_details
  belongs_to :ticket_type,         class_name: "TicketType",     foreign_key: "ticket_category_id",                   inverse_of: :ticket_details 
  belongs_to :ticket_priority,           class_name: "TicketPriority",       foreign_key: "ticket_status_id",                 inverse_of: :ticket_details
  has_many   :ticket_status_histories,   class_name: "TicketStatusHistory",                    inverse_of: :ticket_detail    
  has_many   :ticket_comments, 				       class_name: "TicketComment",      foreign_key: "ticket_detail_id", 			inverse_of: :ticket_detail
  belongs_to :created_by,				       class_name: "User",                 foreign_key: "created_by",  inverse_of: :ticket_details
  has_many   :ticket_user_assignments, class_name: "TicketUserAssignment",   foreign_key: "ticket_detail_id",   inverse_of: :ticket_detail 
  has_many	 :users, class_name: "User", 				:through => :ticket_user_assignments
  
  belongs_to :ticket_sla

  accepts_nested_attributes_for :ticket_comments, allow_destroy: true
  accepts_nested_attributes_for :ticket_user_assignments, allow_destroy: true
  accepts_nested_attributes_for :users, allow_destroy: false

  #enum ticket_priority: {"low" => 0, "normal" => 1, "high" => 2, "critical" => 3}
  #enum ticket_type: {"issue" => 0, "incident" => 1, "complaint" => 2, "bug" => 4, "knowledge" => 4}

  delegate :name, :to => :ticket_category, :allow_nil => true, :prefix => true
  delegate :name, :to => :ticket_status, :allow_nil => true, :prefix => true
  delegate :name, :to => :ticket_type, :allow_nil => true, :prefix => true
  delegate :name, :to => :ticket_priority, :allow_nil => true, :prefix => true

  delegate :order, :to => :ticket_status, :allow_nil => true, :prefix => true
  delegate :order, :to => :ticket_type, :allow_nil => true, :prefix => true
  delegate :order, :to => :ticket_priority, :allow_nil => true, :prefix => true
  
  delegate :name, :to => :ticket_sla, :allow_nil => true, :prefix => true
  delegate :breach, :to => :ticket_sla, :allow_nil => true, :prefix => true
  delegate :warn, :to => :ticket_sla, :allow_nil => true, :prefix => true

  delegate :name, :to => :location, :allow_nil => true, :prefix => true
  delegate :name, :to => :parent, :allow_nil => true, :prefix => true
  delegate :name, :to => :created_by, :allow_nil => true, :prefix => "created_by"

  scope :inclusive, -> { includes(:ticket_category).includes(:ticket_status).includes(:ticket_sla).includes(:location).includes(:users).includes(:parent).includes(:created_by).includes(:ticket_priority).includes(:ticket_type)}
  
  #The database will automatically create the first status of new
  after_update :create_ticket_status_history
  
  #This must be after validation, but before save because saving the record again will cascade status history updates
  after_validation :assign_sla


  

  def create_ticket_status_history

    #If a new ticket has been updated set its status to response, even if no one did that properly.
    self.ticket_status_id = 2 if self.ticket_status_id = 1

    if ticket_status_id_changed? then
      previous_ticket_status_history = TicketStatusHistory.where(:ticket_detail_id => self.id).last
      
      if !previous_ticket_status_history.nil? then
        previous_ticket_status_history.to = DateTime.now
        previous_ticket_status_history.save
      end
      

      ticket_status_history = TicketStatusHistory.new( :ticket_detail_id => self.id, 
                                                          :from => DateTime.now, 
                                                          :ticket_status_id => self.ticket_status_id)
      #if a ticket is complete fill in the to time.
      if self.ticket_status_id == 100 then ticket_status_history.to = DateTime.now end
      
      ticket_status_history.save
    end
    
  end

  def assign_sla
    #Find an exactly matching SLA
    sla = TicketSlaAssignment.where(ticket_category_id: self.ticket_category_id, ticket_priority_id: self.ticket_priority_id, ticket_type_id: self.ticket_type_id) 

    #Find the SLA of a parent category
    if sla.count != 1 then
      sla = TicketSlaAssignment.where("ticket_category_id IN (?)", self.ticket_category.ancestor_ids).where(ticket_priority_id: self.ticket_priority_id, ticket_type_id: self.ticket_type_id).last
    end

    #If that still doesn't work, set it to Normal
    #if sla.nil? then sla = TicketSlaAssignment.find(3)
    
    puts sla
    self.ticket_sla_id = sla.ticket_sla_id
  end

  #####PUT ALL THIS IN A MODULE

  def time_taken_all
    
    
      time_arr= ActiveRecord::Base.connection.select_all("
        SELECT 
            sh.ticket_detail_id
          , sh.from as starttime
          , sh.to as endtime
        FROM ticket_status_histories sh
        JOIN ticket_statuses s 
        ON sh.ticket_status_id = s.id 
        WHERE time_tracked = 1;
      ")
      
      #removed sh.ticket_detail_id = #{self.id} and
      #opening and closing time need to be based on the ticket owner's organisation's hours - 
      #NB third parties therefore cannot be owners
      openingtime = 0.375
      closingtime = 0.75
      tmp_time_accrued = []

      (0..time_arr.rows.count-1).each do |i|


        ticket_detail_id = time_arr.rows[i][0]
        tmp_time_accrued[ticket_detail_id] = tmp_time_accrued[ticket_detail_id] || 0
        starttime = time_arr.rows[i][1]
        endtime = time_arr.rows[i][2] || DateTime.now #doing this rather than using CURRENT_TIMESTAMP() in SQL means that daylight saving is handled.
           
        puts ticket_detail_id

        tmp_time_accrued[ticket_detail_id] = tmp_time_accrued[ticket_detail_id] + time_accrued(starttime, endtime, openingtime, closingtime)
        puts tmp_time_accrued[ticket_detail_id]
      end

      return tmp_time_accrued

    

  end



  def time_taken
    #Move this function to status_history or DB
    begin
      time_arr= ActiveRecord::Base.connection.select_all("
           SELECT 
            sh.ticket_detail_id
          , sh.from as starttime
          , sh.to as endtime
         FROM ticket_status_histories sh
        JOIN ticket_statuses s 
        ON sh.ticket_status_id = s.id 
        WHERE sh.ticket_detail_id = #{self.id} and time_tracked = 1;
      ")

      #opening and closing time need to be based on the ticket owner's organisation's hours - 
      #NB third parties therefore cannot be owners
      openingtime = 0.375
      closingtime = 0.75
      tmp_time_accrued = 0

      (0..time_arr.rows.count-1).each do |i|
        #how to do this in mysql
        #set starttime
        #set end time
        #REPEAT
        # Set startime = DATE_ADD(startime, INTERVAL 1 DAY)
        # UNTIL startime > endtime END REPEAT;

        starttime = time_arr.rows[i][1]
        endtime = time_arr.rows[i][2] || DateTime.now #doing this rather than using CURRENT_TIMESTAMP() in SQL means that daylight saving is handled.
           

        tmp_time_accrued = tmp_time_accrued + time_accrued(starttime, endtime, openingtime, closingtime)
      end

      return tmp_time_accrued

    rescue
      '00:00:00'
    end

  end

  

  def time_accrued(starttime, endtime, openingtime, closingtime)

    
    #starttime = starttime.to_datetime
    #endtime = endtime.to_datetime
    #if status != 'closed' then endtime = DateTime.now end
    #starttime and endtime must be DateTime objects
    #insert an error check here if not

    #openingtime and closingtime are floats
    #eg 12/24 = 0.5 = noon

    period = (starttime.beginning_of_day.to_date..endtime.end_of_day.to_date)

    tmp_time_accrued = 0

    period.each do |d|
      
      
      d = d.to_datetime

      tmp_open = d + openingtime 
      tmp_close = d + closingtime 
      
      
    
      case 
        when starttime < tmp_open 
          tmp_start = tmp_open
        when starttime > tmp_close
          tmp_start = tmp_close
        else
          tmp_start = starttime.to_datetime
      end

      

      case 
          
        when endtime > tmp_close
          tmp_end = tmp_close
        when endtime < tmp_open
          tmp_end = tmp_open
        else
          tmp_end = endtime.to_datetime
      end

      
      if d.saturday? or d.sunday? then 
        #or !d.holiday?(:gb)
        #in mysql you can use date_format to get the weekday or weekday name using %w or %W respectively
      else
        tmp_time_accrued = tmp_time_accrued + (tmp_end - tmp_start)
      end

      
        
      
    end

    
    tmp_time_accrued.to_f

  end

 


  


  

end
