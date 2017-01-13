class RemoveGenresfromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :genre
  end
end
