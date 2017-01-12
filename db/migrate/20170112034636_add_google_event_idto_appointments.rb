class AddGoogleEventIdtoAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :google_event_id, :string
  end
end
