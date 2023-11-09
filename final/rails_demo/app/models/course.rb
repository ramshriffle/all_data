class Course < ApplicationRecord
  belongs_to :college
  has_many :users,dependent: :destroy

  validates :course_name, presence: true, uniqueness: {scope: :college_id, case_sensitive: false, message: "%{value} Course already exists in College"}
end
