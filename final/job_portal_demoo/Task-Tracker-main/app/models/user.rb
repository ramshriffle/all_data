class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  after_create :send_welcome_email
  has_secure_password

  validates :name, :type, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message:"Invalid email id!!!!" }

  private
  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_now
  end

end
