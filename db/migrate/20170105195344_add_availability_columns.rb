class AddAvailabilityColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :day_1, :string, array: true, default: []
    add_column :availabilities, :day_2, :string, array: true, default: []
    add_column :availabilities, :day_3, :string, array: true, default: []
    add_column :availabilities, :day_4, :string, array: true, default: []
    add_column :availabilities, :day_5, :string, array: true, default: []
    add_column :availabilities, :day_6, :string, array: true, default: []
    add_column :availabilities, :day_7, :string, array: true, default: []
  end
end
