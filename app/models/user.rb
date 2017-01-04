class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, :dependent => :destroy
  has_many :trainee_appointments, class_name: :Appointment, foreign_key: :trainee_id
  has_many :trainer_appointments, class_name: :Appointment, foreign_key: :trainer_id

  validates :name, :email, :address, presence: true
  validates :email, uniqueness: true

	  validates :password, length: { minimum: 8 }, on: :create
	  validates :password, confirmation: true, on: :create
	  validates :password_confirmation, presence: true, on: :create

  accepts_nested_attributes_for :authentications

  def has_linked_google?
     authentications.where(provider: 'google').present?
  end

  def self.search(search)
    where("name ILIKE ? OR address ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
