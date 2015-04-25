require 'rails_helper'

RSpec.describe "Ticket::Statuses", type: :request do
  describe "GET /ticket_statuses" do
    it "works! (now write some real specs)" do
      get ticket_statuses_path
      expect(response).to have_http_status(200)
    end
  end
end
