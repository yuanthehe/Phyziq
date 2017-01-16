class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, :dependent => :destroy
  has_many :trainee_appointments, class_name: :Appointment, foreign_key: :trainee_id
  has_many :trainer_appointments, class_name: :Appointment, foreign_key: :trainer_id
  has_many :availabilities
  has_one :category


  validates :name, :email, :address, presence: true
  validates :email, uniqueness: true

	  validates :password, length: { minimum: 8 }, on: :create
	  validates :password, confirmation: true, on: :create
	  validates :password_confirmation, presence: true, on: :create

  accepts_nested_attributes_for :authentications
  accepts_nested_attributes_for :category
  accepts_nested_attributes_for :trainee_appointments, allow_destroy: true
  accepts_nested_attributes_for :trainer_appointments, allow_destroy: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def has_linked_google?
     authentications.where(provider: 'google').present?
  end

  def self.search(search)
    where("name ILIKE ? OR address ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
