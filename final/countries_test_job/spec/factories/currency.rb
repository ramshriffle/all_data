FactoryBot.define do
  factory :currency, class: 'Currency' do
    alpha_two { 'US' }
    currency_code { 'USD' }
    currency_name { 'United States Dollar' }
    exchange_rate { '0.0' }
    country
  end
end
