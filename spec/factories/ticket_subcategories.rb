FactoryGirl.define do
  factory :ticket_subcategory, :class => 'Ticket::Subcategory' do
    ticket_category nil
name "MyString"
  end

end
