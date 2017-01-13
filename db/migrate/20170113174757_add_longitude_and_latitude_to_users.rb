class AddLongitudeAndLatitudeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :latitude, :decimal, precision: 9, scale: 6
    add_column :users, :longitude, :decimal, precision: 9, scale: 6
  end
end
