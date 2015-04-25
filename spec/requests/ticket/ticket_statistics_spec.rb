require 'rails_helper'

RSpec.describe "Ticket::Statistics", type: :request do
  describe "GET /ticket_statistics" do
    it "works! (now write some real specs)" do
      get ticket_statistics_path
      expect(response).to have_http_status(200)
    end
  end
end
