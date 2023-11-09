# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  describe 'Associations' do
    it { should belong_to(:customer) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(order).to be_valid
    end
  end

  describe 'Outputs' do
    it "price return positive integer" do
      expect(order.order_price).to be >= 0
    end
  end
end
