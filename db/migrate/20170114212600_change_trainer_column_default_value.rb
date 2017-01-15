class ChangeTrainerColumnDefaultValue < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :trainer, false
  end
end
