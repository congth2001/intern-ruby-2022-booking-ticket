require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe "GET /home" do
    it "returns http success" do
      get "/static_pages/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get "/static_pages/help"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /cinemas" do
    it "returns http success" do
      get "/static_pages/cinemas"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /film" do
    it "returns http success" do
      get "/static_pages/film"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /ticket" do
    it "returns http success" do
      get "/static_pages/ticket"
      expect(response).to have_http_status(:success)
    end
  end

end
