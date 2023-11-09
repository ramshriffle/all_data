class College < ApplicationRecord
  belongs_to :address
  has_many :courses, dependent: :destroy

  validates :college_name, presence: true, uniqueness: {scope: :address_id, case_sensitive: false, message: "%{value} College already exit in the city"}

  
end
