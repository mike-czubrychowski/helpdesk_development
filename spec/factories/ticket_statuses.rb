FactoryGirl.define do
  factory :ticket_status, :class => 'Ticket::Status' do
    name nil
order 1
time_tracked false
  end

end
