class User < ApplicationRecord
  has_many :trainers, through: :appointments, source: :user
  has_many :trainees, through: :appointments, source: :user

  authenticates_with_sorcery!

  validates :name, :email, :address, presence: true
  validates :email, uniqueness: true

	validates :password, length: { minimum: 8 }, on: :create
	validates :password, confirmation: true, on: :create
	validates :password_confirmation, presence: true, on: :create

end
