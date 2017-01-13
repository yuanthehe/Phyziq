class AddLongitudeLatitudeToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :latitude, :decimal, precision: 9, scale: 6
    add_column :appointments, :longitude, :decimal, precision: 9, scale: 6
    add_column :appointments, :address, :string
  end
end
