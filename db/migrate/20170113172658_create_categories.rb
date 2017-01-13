class CreateCategories < ActiveRecord::Migration[5.0]
  def up
    drop_table :categories

    create_table :categories do |t|

      t.timestamps
    end
  end
end
