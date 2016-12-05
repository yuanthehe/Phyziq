class User < ApplicationRecord
  has_many :trainers, through: :appointments, source: :user
  has_many :trainees, through: :appointments, source: :user

  validates :name, :email, :address, presence: true

  #has_secure_password
end
