class Address < ApplicationRecord
    has_many :colleges, dependent: :destroy

    validates :city, presence: true, uniqueness: {case_sensitive: false, message: "%{value} city already exits"}
end
