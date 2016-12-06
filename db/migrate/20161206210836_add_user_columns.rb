class AddUserColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :trainer, :boolean
    add_column :users, :password_digest, :string
  end
end
