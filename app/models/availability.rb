class Availability < ApplicationRecord
  belongs_to :trainer, class_name: :User
  belongs_to :trainee, class_name: :User
end
