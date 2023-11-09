class Country < ApplicationRecord
  validates :name, :alpha_two, :alpha_three, :country_code, :nationality, :continent, presence: true
  default_scope { where(deleted: false) }
  has_many :currencies, dependent: :destroy
end
