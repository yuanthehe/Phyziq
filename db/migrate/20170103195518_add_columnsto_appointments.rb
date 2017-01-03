class AddColumnstoAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :start_time, :datetime
    add_column :appointments, :end_time, :datetime

    remove_column :appointments, :time
  end
end
