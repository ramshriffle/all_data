# == Schema Information
#
# Table name: order_items
#
#  id                 :integer          not null, primary key
#  price              :decimal(, )      default(0.0), not null
#  quantity           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  order_id           :integer          not null
#  restaurant_dish_id :integer
#
# Indexes
#
#  index_order_items_on_order_id            (order_id)
#  index_order_items_on_restaurant_dish_id  (restaurant_dish_id)
#
# Foreign Keys
#
#  order_id            (order_id => orders.id)
#  restaurant_dish_id  (restaurant_dish_id => restaurant_dishes.id)
#
FactoryBot.define do
  factory :order_item do
    price { 100 }
    quantity { 5 }
    order { FactoryBot.create(:order) }
    restaurant_dish { FactoryBot.create(:restaurant_dish) }
  end
end
