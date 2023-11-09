require 'rails_helper'

include TokenHelper

RSpec.describe "Restaurants", type: :request do

  let(:owner) { FactoryBot.create(:user, type: Owner) }
  let(:owner_token) { user_token(owner)}
  let(:customer) { FactoryBot.create(:user, type: Customer) }
  let(:customer_token) { user_token(customer) }
  let(:restaurant){ create(:restaurant, owner_id: owner.id) }
  let(:rd) { FactoryBot.create(:restaurant_dish, dish: FactoryBot.create(:dish), restaurant: restaurant) }

  describe "GET /index" do
    it "return list of restaurants" do
      get '/api/v1/restaurants', headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return list of restaurants for status" do
      get '/api/v1/restaurants', params: { status: "open" }, headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return error for wrong status" do
      get '/api/v1/restaurants', params: { status: "dummy" }, headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe "POST /create" do
    let(:restaurant) { build_stubbed(:restaurant) }
    it "return created successfully" do
      post '/api/v1/restaurants', params: restaurant.as_json , headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return unprocessable_entity message" do
      restaurant.restaurant_name = nil
      post '/api/v1/restaurants', params: restaurant.as_json, headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "return error for wrong status" do
      restaurant_json = restaurant.as_json
      restaurant_json[:status] = "undefined"
      post '/api/v1/restaurants', params: restaurant_json, headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:internal_server_error)
    end

    it "return unauthorized for customer" do
      post '/api/v1/restaurants', params: restaurant.as_json, headers: { Authorization: "bearer #{customer_token}" }
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "GET /restaurants" do
    it "return restaurant" do
      get "/api/v1/restaurants/#{restaurant.id}", headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return not_found restaurant" do
      get "/api/v1/restaurants/#{restaurant.id-1}", headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /restaurants" do
    it "return restaurant" do
      put "/api/v1/restaurants/#{restaurant.id}", params: { restaurant_name: "Maa ki Rasoi" }, headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return unprocessable_entity restaurant" do
      put "/api/v1/restaurants/#{restaurant.id}", params: { restaurant_name: nil }, headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "return not_found restaurant" do
      put "/api/v1/restaurants/#{restaurant.id-1}", params: { restaurant_name: nil }, headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /restaurants" do
    it "return restaurant" do
      delete "/api/v1/restaurants/#{restaurant.id}", headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return not_found restaurant" do
      delete "/api/v1/restaurants/#{restaurant.id-1}", headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /restaurants/id/dishes" do

    it "return dishes of restaurants" do
      # not create until we access it in "let(){}"
      rd  # this line try to access rd to create dish for restaurant
      get "/api/v1/restaurants/#{restaurant.id}/dishes", headers: { Authorization: "bearer #{owner_token}" }
      expect(response).to have_http_status(:ok)
    end
  end
end
