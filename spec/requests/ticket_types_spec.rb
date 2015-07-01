require 'rails_helper'

RSpec.describe "TicketTypes", type: :request do
  describe "GET /ticket_types" do
    it "works! (now write some real specs)" do
      get ticket_types_path
      expect(response).to have_http_status(200)
    end
  end
end
