require 'rails_helper'

RSpec.describe "Ticket::Subcategories", type: :request do
  describe "GET /ticket_subcategories" do
    it "works! (now write some real specs)" do
      get ticket_subcategories_path
      expect(response).to have_http_status(200)
    end
  end
end
