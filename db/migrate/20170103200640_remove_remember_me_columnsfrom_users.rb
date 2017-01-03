class RemoveRememberMeColumnsfromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :remember_me_token

    remove_column :users, :remember_me_token_expires_at
    remove_column :users, :remember_me_token
  end
end
