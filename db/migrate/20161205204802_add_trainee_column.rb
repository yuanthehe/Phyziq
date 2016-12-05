class AddTraineeColumn < ActiveRecord::Migration[5.0]
  def change
      add_column :appointments, :trainee_id, :integer
  end
end
