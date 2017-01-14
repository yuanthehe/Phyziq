class FixingCategoryColumnNames < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :kickboxing, :boolean, default: false

    remove_column :categories, :martial_arts
    rename_column :categories, :cross_fit, :crossfit
    rename_column :categories, :weight_lifting, :weightlifting
  end
end
