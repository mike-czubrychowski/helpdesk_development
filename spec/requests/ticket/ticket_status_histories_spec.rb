require 'rails_helper'

RSpec.describe "Ticket::StatusHistories", type: :request do
  describe "GET /ticket_status_histories" do
    it "works! (now write some real specs)" do
      get ticket_status_histories_path
      expect(response).to have_http_status(200)
    end
  end
end
