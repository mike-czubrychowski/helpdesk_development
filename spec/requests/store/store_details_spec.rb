require 'rails_helper'

RSpec.describe "Store::Details", type: :request do
  describe "GET /store_details" do
    it "works! (now write some real specs)" do
      get store_details_path
      expect(response).to have_http_status(200)
    end
  end
end
