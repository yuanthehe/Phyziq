class AddNextSixDaysColumntoAvailabilities < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :next_six_days, :string, array: true, default: []
  end
end
