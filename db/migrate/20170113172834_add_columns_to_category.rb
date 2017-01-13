class AddColumnsToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :weight_lifting, :boolean, default:false
    add_column :categories, :cross_fit, :boolean, default:false
    add_column :categories, :yoga, :boolean, default:false
    add_column :categories, :cardio, :boolean, default:false
    add_column :categories, :running, :boolean, default:false
    add_column :categories, :squash, :boolean, default:false
    add_column :categories, :boxing, :boolean, default:false
    add_column :categories, :martial_arts, :boolean, default:false
  end
end
