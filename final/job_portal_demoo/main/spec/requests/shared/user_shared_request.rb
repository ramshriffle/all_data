shared_examples "user_shared_request" do
  describe "POST create" do
    let(:new_user) { FactoryBot.build_stubbed(:user) }

    it "return a successful response" do
      new_user_json = new_user.as_json(only: [:name, :username, :email, :profile_picture]).merge({password: new_user.password, password_confirmation: new_user.password})

      new_user_json[:profile_picture] = fixture_file_upload(Rails.root.join('app/assets/test_image.png'), 'image/png')

      post "/api/v1/#{path}", params: new_user_json
      data = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(data["data"]['username']).to eq new_user[:username]
      expect(data["data"]['profile_picture']).to_not eq nil
    end

    it "return unprocessable_entity for user" do
      new_user.username = "--d--"
      post "/api/v1/#{path}", params: new_user.as_json(only: [:name, :username, :email])
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /user" do
    it "return user data" do
      get "/api/v1/#{path}", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return unauthorized" do
      get "/api/v1/#{path}", headers: { Authorization: "bearer #{0000}" }
      expect(response).to have_http_status(:unauthorized)
    end
    it "return record not found" do
      token = JsonWebToken.encode(user_id: 0)
      get "/api/v1/#{path}", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /user" do
    it "return successful message" do
      put "/api/v1/#{path}", params: user.as_json, headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
    it "return unprocessable_entity user" do
      user.username = "--0--"
      put "/api/v1/#{path}", params: user.as_json, headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /user" do
    it "return successful message" do
      delete "/api/v1/#{path}", headers: { Authorization: "bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
  end
end
