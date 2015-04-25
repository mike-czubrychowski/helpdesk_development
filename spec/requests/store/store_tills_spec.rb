require 'rails_helper'

RSpec.describe "Store::Tills", type: :request do
  describe "GET /store_tills" do
    it "works! (now write some real specs)" do
      get store_tills_path
      expect(response).to have_http_status(200)
    end
  end
end
