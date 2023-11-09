class CreateCountries < ActiveRecord::Migration[5.2]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :countries do |t|
      t.string :name
      t.string :alpha_two
      t.string :alpha_three
      t.string :country_code
      t.string :continent
      t.string :nationality
      t.boolean :deleted, default: false, null: false
      t.timestamps
    end
    add_index :countries, %i[alpha_two alpha_three], unique: true
  end
  # rubocop:enable Metrics/MethodLength
end
