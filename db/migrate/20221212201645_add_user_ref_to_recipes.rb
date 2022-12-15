class AddUserRefToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :user, null: false, foreign_key: {on_delete: :cascade}
  end
end
