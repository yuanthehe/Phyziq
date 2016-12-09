class AddGoogleLoginColumnToUserTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :google_login, :string
  end
end
