require 'rails_helper'

RSpec.describe CountriesController do
  describe 'GET #index' do
    it 'returns a list of countries' do
      create_list(:country, 3)
      get :index
      expect(response.parsed_body['countries'].size).to eq(3)
    end

    it 'filters countries by currency_code' do
      country = create(:country)
      create(:currency, country: country, currency_code: 'USD')
      get :index, params: { currency_code: ['usd'] }
      expect(response.parsed_body['countries'].size).to eq(1)
    end
  end

  describe 'GET #country' do
    it 'returns a country by alpha_two' do
      country = create(:country)
      get :country, params: { alpha_two: country.alpha_two }
      expect(response).to have_http_status(:ok)
    end

    it 'returns a country by alpha_three' do
      country = create(:country)
      get :country, params: { alpha_three: country.alpha_three }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    it 'soft deletes a country' do
      country = create(:country)
      delete :destroy, params: { id: country.id }
      expect(response).to have_http_status(:ok)
    end

    it 'indicates country is soft-deleted' do
      country = create(:country)
      delete :destroy, params: { id: country.id }
      expect(response.parsed_body['country']['deleted']).to be_truthy
    end

    it 'returns not found if country not found' do
      delete :destroy, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns error if country not updated' do
      country = create(:country, alpha_two: nil)
      delete :destroy, params: { id: country.id }
      expect(response.parsed_body['errors'][0]).to eql("Alpha two can't be blank")
    end
  end
end
