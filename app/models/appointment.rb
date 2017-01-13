class Appointment < ApplicationRecord
  belongs_to :trainer, class_name: :User
  belongs_to :trainee, class_name: :User

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
