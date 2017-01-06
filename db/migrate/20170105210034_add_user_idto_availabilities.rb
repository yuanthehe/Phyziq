class AddUserIdtoAvailabilities < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :user_id, :integer
  end
end
