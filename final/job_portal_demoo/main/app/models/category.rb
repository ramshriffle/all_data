# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  category_name :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Category < ApplicationRecord
  validates :category_name, presence: true, uniqueness: { case_sensitive: false }
  has_many :dishes
end
