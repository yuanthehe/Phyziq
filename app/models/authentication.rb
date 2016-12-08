class Authentication < ApplicationRecord
  belongs_to :user
  attr_accessor :user_id, :provider, :uid
end
