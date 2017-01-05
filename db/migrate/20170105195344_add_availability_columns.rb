class AddAvailabilityColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :day_1, array: true, default: []
    add_column :availabilities, :day_2, array: true, default: []
    add_column :availabilities, :day_3, array: true, default: []
    add_column :availabilities, :day_4, array: true, default: []
    add_column :availabilities, :day_5, array: true, default: []
    add_column :availabilities, :day_6, array: true, default: []
    add_column :availabilities, :day_7, array: true, default: []
  end
end
