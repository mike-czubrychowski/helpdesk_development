FactoryGirl.define do
  factory :ticket_detail, :class => 'Ticket::Detail' do
    location nil
parent nil
type 1
category nil
subcategory nil
priority 1
status nil
comment nil
name "MyString"
description ""
created_by nil
updated_by nil
  end

end
