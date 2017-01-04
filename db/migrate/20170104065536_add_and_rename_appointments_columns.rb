class AddAndRenameAppointmentsColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :appointments, :invitation_status, :event_invitation_status
    rename_column :appointments, :start_time, :event_start_time
    rename_column :appointments, :end_time, :event_end_time

    add_column :appointments, :event, :boolean
    add_column :appointments, :available_time_slot, :datetime
  end
end
