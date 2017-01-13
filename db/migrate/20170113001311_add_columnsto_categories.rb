class AddColumnstoCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :description, :string
    add_column :categories, :status, :boolean
  end
end
