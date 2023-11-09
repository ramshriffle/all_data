class College < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :courses, dependent: :destroy
    has_many :address, as: :addressible, dependent: :destroy

    validates :college_name, presence: true,uniqueness: {message: "%{value} college is already exists"}
end
