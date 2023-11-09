require 'rails_helper'

include TokenHelper

RSpec.describe "Carts", type: :request do
  let(:customer) { FactoryBot.create(:user, type: Customer) }
  let(:customer_token) { user_token(customer) }
  let(:cart) { create(:cart, customer_id: customer.id) }
  let(:restaurant_dish) { FactoryBot.create(:restaurant_dish) }
  let(:cart_item) { FactoryBot.create(:cart_item, cart: cart, restaurant_dish: restaurant_dish) }

  describe "GET /cart" do
    it "return empty cart" do
      get '/api/v1/cart', headers: { Authorization: "bearer #{customer_token}" }
      expect(response).to have_http_status(:not_found)
    end
    it "return cart" do
      cart_item # let is lazy initializer
      get '/api/v1/cart', headers: { Authorization: "bearer #{customer_token}" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /cart" do
    it "return successful deleted" do
      cart # cart not created untill we access it
      delete '/api/v1/cart', headers: { Authorization: "bearer #{customer_token}" }
      expect(response).to have_http_status(:ok)
    end
  end
end
