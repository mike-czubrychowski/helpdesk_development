require 'rails_helper'

RSpec.describe "TicketPriorities", type: :request do
  describe "GET /ticket_priorities" do
    it "works! (now write some real specs)" do
      get ticket_priorities_path
      expect(response).to have_http_status(200)
    end
  end
end
