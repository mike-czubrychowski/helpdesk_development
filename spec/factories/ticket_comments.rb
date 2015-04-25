FactoryGirl.define do
  factory :ticket_comment, :class => 'Ticket::Comment' do
    detail nil
name "MyString"
description ""
type 1
created_by nil
updated_by nil
  end

end
