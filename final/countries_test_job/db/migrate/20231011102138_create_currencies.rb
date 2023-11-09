class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :alpha_two
      t.string :currency_code
      t.string :currency_name
      t.float :exchange_rate
      t.belongs_to :country

      t.timestamps
    end
  end
end
