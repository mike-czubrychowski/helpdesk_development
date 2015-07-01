module TimeTracker 
  
  def time_taken_all
    puts 'TEST'  
    begin
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
      puts 'HERE'
      openingtime = 0.375
      closingtime = 0.75
      tmp_time_accrued = []


      (0..time_arr.rows.count-1).each do |i|
        puts 'WHAT UP DOG'
        ticket_detail_id = time_arr.rows[i][0]
        starttime = time_arr.rows[i][1]
        endtime = time_arr.rows[i][2] || DateTime.now #doing this rather than using CURRENT_TIMESTAMP() in SQL means that daylight saving is handled.
        p ticket_detail_id

        tmp_time_accrued[ticket_detail_id] = tmp_time_accrued[ticket_detail_id] + time_accrued(starttime, endtime, openingtime, closingtime)
      end
      puts tmp_time_accrued
      return tmp_time_accrued

    rescue
      nil
    end

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

      tmp_time_accrued = format_time(tmp_time_accrued)
      return tmp_time_accrued

    rescue
      '00:00:00'
    end

  end

  def format_time(time)
    begin
      hours = (time * 24).to_i
      minutes = Time.at(time * (60 * 60 * 24)).utc.strftime("%M:%S")
      hours.to_s + ":" + minutes.to_s
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