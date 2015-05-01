class StatusHistoryMailer < ActionMailer::Base
   default :from => "helpdesk@caffenero.com"

   def post_email(user)
    	mail(:to => "tom.giles@gmail.com", :subject => "She lives!")
   end
 end