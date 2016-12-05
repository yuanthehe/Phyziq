class Appointment < ApplicationRecord
  belongs_to :trainer, class_name: :user
  belongs_to :trainee, class_name: :user
end
