require 'csv'

csv_text = Rails.root.join('db/seed_files/countries.csv').read
csv = CSV.parse(csv_text, headers: false, encoding: 'ISO-8859-1')

csv.each do |row|
  country_name, alpha_two, alpha_three, country_code, continent, nationality = row
  country = Country.find_or_initialize_by(name: country_name, alpha_two: alpha_two, alpha_three: alpha_three,
                                          country_code: country_code, continent: continent, nationality: nationality)
  country.save!
end
