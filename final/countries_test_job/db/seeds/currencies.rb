require 'csv'

csv_text = Rails.root.join('db/seed_files/currencies.csv').read
csv = CSV.parse(csv_text, headers: false, encoding: 'ISO-8859-1')
countries_cache = Country.pluck(:alpha_two, :id).to_h

csv.each do |row|
  alpha_two, currency_code, currency_name, exchange_rate = row
  country_id = countries_cache[alpha_two]
  currency = Currency.find_or_initialize_by(alpha_two: alpha_two,
                                            currency_code: currency_code, currency_name: currency_name,
                                            exchange_rate: exchange_rate, country_id: country_id)
  currency.save!
end
