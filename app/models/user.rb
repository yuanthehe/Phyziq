class User < ApplicationRecord

  attr_accessor :email, :password, :password_confirmation, :authentications_attributes

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  has_many :trainers, through: :appointments, source: :user
  has_many :trainees, through: :appointments, source: :user

  validates :name, :email, :address, presence: true
  validates :email, uniqueness: true

	validates :password, length: { minimum: 8 }, on: :create
	validates :password, confirmation: true, on: :create
	validates :password_confirmation, presence: true, on: :create

  def has_linked_google?
    authentications.where(provider: 'google').present?
  end

end
