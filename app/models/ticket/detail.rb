class Ticket::Detail < ActiveRecord::Base

  include ActiveModel::Dirty
  #require 'date' 

  belongs_to :location,																  				inverse_of: :ticket_details
  belongs_to :parent,   				class_name: "Ticket::Detail",                             	inverse_of: :children
  has_many 	 :children,   			class_name: "Ticket::Detail",              foreign_key: "parent_id", 	inverse_of: :parent  
  belongs_to :ticket_category, 				 class_name: "Ticket::Category",     foreign_key: "ticket_category_id", 							  	inverse_of: :ticket_details	
  belongs_to :ticket_subcategory, 		 class_name: "Ticket::Subcategory",  foreign_key: "ticket_subcategory_id",  							inverse_of: :ticket_details
  belongs_to :ticket_status, 					 class_name: "Ticket::Status",       foreign_key: "ticket_status_id", 								inverse_of: :tickets
  has_many   :ticket_status_histories,   class_name: "Ticket::StatusHistory",                    inverse_of: :ticket_detail    
  has_many   :comments, 				       class_name: "Ticket::Comment",      foreign_key: "ticket_detail_id", 			inverse_of: :ticket
  belongs_to :created_by,				       class_name: "User",                 foreign_key: "created_by",  inverse_of: :tickets
 
  has_many   :ticket_user_assignments, class_name: "Ticket::UserAssignment",   foreign_key: "ticket_detail_id",   inverse_of: :ticket_detail 
  has_many	 :users, class_name: "User", 				:through => :ticket_user_assignments
  

  accepts_nested_attributes_for :comments, allow_destroy: true
  accepts_nested_attributes_for :ticket_user_assignments, allow_destroy: true
  accepts_nested_attributes_for :users, allow_destroy: false

  enum ticket_priority: {"low" => 0, "normal" => 1, "high" => 2, "critical" => 3}
  enum ticket_type: {"issue" => 0, "incident" => 1, "complaint" => 2, "bug" => 4, "knowledge" => 4}

  delegate :name, :to => :ticket_category, :allow_nil => true, :prefix => "ticket_category"
  delegate :name, :to => :ticket_subcategory, :allow_nil => true, :prefix => "ticket_subcategory" #not working
  delegate :name, :to => :ticket_status, :allow_nil => true, :prefix => "ticket_status"
  delegate :name, :to => :location, :allow_nil => true, :prefix => true
  delegate :name, :to => :parent, :allow_nil => true, :prefix => true

  scope :inclusive, -> { includes(:ticket_subcategory).includes(:ticket_category).includes(:ticket_status).includes(:location)}
  
  after_save :create_ticket_status_history

  def create_ticket_status_history
    if ticket_status_id_changed? then
      previous_ticket_status_history = Ticket::StatusHistory.where(:ticket_detail_id => self.id).last
      
      if !previous_ticket_status_history.nil? then
        previous_ticket_status_history.to = DateTime.now
        previous_ticket_status_history.save
      end
      
      ticket_status_history = Ticket::StatusHistory.new( :ticket_detail_id => self.id, 
                                                          :from => DateTime.now, 
                                                          :ticket_status_id => self.ticket_status_id)
      #if a ticket is complete fill in the to time.
      if self.ticket_status_id == 100 then ticket_status_history.to = DateTime.now end
      
      ticket_status_history.save
    end
    
  end

  def time_taken

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

    openingtime = 0.375
    closingtime = 0.75
    tmp_time_accrued = 0

    (0..time_arr.rows.count-1).each do |i|
      

      starttime = time_arr.rows[i][1]
      endtime = time_arr.rows[i][2] || DateTime.now #doing this rather than using CURRENT_TIMESTAMP() in SQL means that daylight saving is handled.
         

      tmp_time_accrued = tmp_time_accrued + time_accrued(starttime, endtime, openingtime, closingtime)
    end

    hours = (tmp_time_accrued * 24).to_i
    minutes = Time.at(tmp_time_accrued * (60 * 60 * 24)).utc.strftime("%M:%S")
    hours.to_s + ":" + minutes.to_s
    #tmp_time_accrued.to_f.to_s + '  ' + ((holdtime.to_f) / (60 * 60 * 24)).to_s


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
      
      puts '--------'
      puts tmp_time_accrued
      puts d
      d = d.to_datetime

      tmp_open = d + openingtime 
      tmp_close = d + closingtime 
      
      puts 'opens ' + tmp_open.to_s
      puts 'close ' + tmp_close.to_s 
    
      case 
        when starttime < tmp_open 
          tmp_start = tmp_open
        when starttime > tmp_close
          tmp_start = tmp_close
        else
          tmp_start = starttime.to_datetime
      end

      puts tmp_start

      case 
          
        when endtime > tmp_close
          tmp_end = tmp_close
        when endtime < tmp_open
          tmp_end = tmp_open
        else
          tmp_end = endtime.to_datetime
      end

      puts tmp_end
      puts '---time diff'
      puts tmp_end - tmp_start

      puts '-------Saturday theyre paying'
      puts d.saturday?
      puts d.sunday?

      if d.saturday? or d.sunday? then 
        #or !d.holiday?(:gb)
      else
        tmp_time_accrued = tmp_time_accrued + (tmp_end - tmp_start)
      end

      puts 'accrued'
      puts tmp_time_accrued
        
      
    end

    
    tmp_time_accrued.to_f

    # = tmp_time_accrued.to_f - ((holdtime.to_f) / (60 * 60 * 24))
    #hours = (tmp_time_accrued * 24).to_i
    #minutes = Time.at(tmp_time_accrued * (60 * 60 * 24)).utc.strftime("%M:%S")
    #hours.to_s + ":" + minutes.to_s
    #tmp_time_accrued.to_f.to_s + '  ' + ((holdtime.to_f) / (60 * 60 * 24)).to_s

  end

  

  

  def created_by_name
    begin
      #not working
      self.created_by.person.name
    rescue
      nil
    end
  end

 

end
