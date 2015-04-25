require 'rails_helper'

RSpec.describe "Ticket::Users", type: :request do
  describe "GET /ticket_users" do
    it "works! (now write some real specs)" do
      get ticket_users_path
      expect(response).to have_http_status(200)
    end
  end
end
