class User < ApplicationRecord
    belongs_to :college
    belongs_to :course
    has_one :address, as: :addressible,dependent: :destroy

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, format: {  with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,message: "Please Enter Valid Email" }end
