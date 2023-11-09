class Address < ApplicationRecord
    belongs_to :addressible, polymorphic: true
    
    validates :city, presence: true, uniqueness: {scope: [:addressible_id,:addressible_type], message: "city already exists"}
    validates :addressible_type, presence: true
    validates :addressible_id, presence: true
end
