class CountriesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]
  before_action :find_country, only: [:destroy]
  def index
    countries = Country.all
    if filter_params[:currency_code].present?
      countries = countries.joins(:currencies)
                           .where(currencies: { currency_code: filter_params[:currency_code].map(&:upcase) })
    end
    render json: { countries: countries }, status: :unprocessable_entity
  end

  def country
    country = if alpha_params[:alpha_two].present?
                Country.find_by(alpha_two: alpha_params[:alpha_two])
              else
                Country.find_by(alpha_three: alpha_params[:alpha_three])
              end
    render json: { country: country }, status: :ok
  end

  def destroy
    if @country.update(deleted: true)
      render json: { country: @country }, status: :ok
    else
      render json: { errors: @country.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def delete_params
    params.permit(:id)
  end

  def filter_params
    params.permit(currency_code: [])
  end

  def find_country
    @country = Country.find_by(id: delete_params[:id])
    render json: { errors: 'Country not found' }, status: :not_found unless @country
  end

  def alpha_params
    params.permit(:alpha_two, :alpha_three)
  end
end
