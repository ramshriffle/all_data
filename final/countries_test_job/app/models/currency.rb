class Currency < ApplicationRecord
  validates :alpha_two, :currency_code, :currency_code, presence: true
  belongs_to :country
end
