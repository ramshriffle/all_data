class Course < ApplicationRecord
  belongs_to :college

  after_destroy :destroy_action

  validates :name, presence: true, uniqueness: {scope: :college_id, message: "%{value} Course already exit in the college"}
  
  def destroy_action
    puts 'Courses destroyed'
  end
end
