# == Schema Information
#
# Table name: carts
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#
# Indexes
#
#  index_carts_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => users.id)
#
FactoryBot.define do
  factory :cart do
    customer_id { FactoryBot.create(:user, type: "Customer").id }
  end
end
