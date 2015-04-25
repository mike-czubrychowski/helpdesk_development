require 'rails_helper'

RSpec.describe "Ticket::Details", type: :request do
  describe "GET /ticket_details" do
    it "works! (now write some real specs)" do
      get ticket_details_path
      expect(response).to have_http_status(200)
    end
  end
end
