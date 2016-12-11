class DropGoogleLoginColumnFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :google_login
  end
end
