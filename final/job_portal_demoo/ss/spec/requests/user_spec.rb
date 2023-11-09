require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user, type: "Owner") }

  describe "POST /login" do
    it "return login successful message" do
      post '/login', params: {
        username: user.username,
        password: user.password
      }
      expect(response).to have_http_status(:ok) # 200
    end
    it "return unauthorized" do
      post '/login', params: {
        username: '0000',
        password: '0000'
      }
      expect(response).to have_http_status(:unauthorized) # 401
    end
  end

  describe "DELETE /logout" do
    it "return logout successful message" do
      delete '/logout'
      expect(response).to have_http_status(:ok) # 200
    end
  end

  describe "POST /forgot_password" do
    it "return success" do
      post '/forgot_password', params: { username: user.username }
      expect(response).to have_http_status(:ok) # 200
    end
    it "return not_found userame" do
      post '/forgot_password', params: { username: "--d--" }
      expect(response).to have_http_status(:not_found) # 404
    end
    it "return username must exist" do
      post '/forgot_password'
      expect(response).to have_http_status(:not_found) # 404
    end
  end

  describe "POST /reset_password" do
    it "return success" do
      post '/reset_password', params: { token: user.reset_password_token, password: "Ugh123" }
      expect(response).to have_http_status(:ok) # 200
    end
    it "return not_found token" do
      post '/reset_password', params: { token: nil, password: "Ugh123" }
      expect(response).to have_http_status(:not_found) # 404
    end
    it "return unprocessable_entity" do
      post '/reset_password', params: { token: user.reset_password_token, password: "Ugh" }
      expect(response).to have_http_status(:unprocessable_entity) # 422
    end
    it "return expire token" do
      post '/reset_password', params: { token: '0000', password: "Ugh123" }
      expect(response).to have_http_status(:gone) # 410
    end
  end
end
