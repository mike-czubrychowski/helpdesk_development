require 'rails_helper'

RSpec.describe "Ticket::Comments", type: :request do
  describe "GET /ticket_comments" do
    it "works! (now write some real specs)" do
      get ticket_comments_path
      expect(response).to have_http_status(200)
    end
  end
end
