class User < ApplicationRecord
  authenticates_with_sorcery!

  # has_many :trainers, through: :appointments, source: :user
  # has_many :trainees, through: :appointments, source: :user
  #use attr for items want to track NOT in database
  has_many :authentications, :dependent => :destroy

  validates :name, :email, :address, presence: true
  validates :email, uniqueness: true

	  validates :password, length: { minimum: 8 }, on: :create
	  validates :password, confirmation: true, on: :create
	  validates :password_confirmation, presence: true, on: :create

  accepts_nested_attributes_for :authentications

  def has_linked_google?
     authentications.where(provider: 'google').present?
  end
end
