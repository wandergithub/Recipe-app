class ChangeColumnsTypes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :preparation_time
    remove_column :recipes, :cooking_time
    add_column :recipes, :preparation_time, :float, :default => 0.0
    add_column :recipes, :cooking_time, :float, :default => 0.0 
  end
end
