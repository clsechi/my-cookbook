class RemoveUserIdFromFavoriteRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :favorite_recipes, :user_id, :integer
  end
end
