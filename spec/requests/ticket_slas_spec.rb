require 'rails_helper'

RSpec.describe "TicketSlas", type: :request do
  describe "GET /ticket_slas" do
    it "works! (now write some real specs)" do
      get ticket_slas_path
      expect(response).to have_http_status(200)
    end
  end
end
