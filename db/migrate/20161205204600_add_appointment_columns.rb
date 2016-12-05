class AddAppointmentColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :trainer_id, :integer
  end
end
