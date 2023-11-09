class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :addressible_type
      t.integer :addressible_id

      t.timestamps
    end
  end
end
