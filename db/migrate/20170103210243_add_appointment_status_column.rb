class AddAppointmentStatusColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :invitation_status, :boolean
  end
end
