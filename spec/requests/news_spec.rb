require 'rails_helper'

RSpec.describe "News", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/news/show"
      expect(response).to have_http_status(:success)
    end
  end

end
