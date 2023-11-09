FactoryBot.define do
  factory :country do
    sequence(:alpha_two) { |n| "US#{n}" }
    sequence(:alpha_three) { |n| "USA#{n}" }
    name { 'United States' }
    nationality { 'American' }
    continent { 'North America' }
    country_code { '1' }
    to_create { |instance| instance.save(validate: false) }
  end
end
