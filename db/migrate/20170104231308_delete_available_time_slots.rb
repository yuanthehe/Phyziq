class DeleteAvailableTimeSlots < ActiveRecord::Migration[5.0]
  def change
    remove_column :appointments, :available_time_slot
  end
end
