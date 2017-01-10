class AddSummaryToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :summary, :string
  end
end
