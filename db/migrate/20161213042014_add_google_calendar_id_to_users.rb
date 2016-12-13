class AddGoogleCalendarIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :google_calendar_id, :string
  end
end
