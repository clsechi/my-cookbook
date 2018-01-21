class RemoveRecipeIdFromFavoriteRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :favorite_recipes, :recipe_id, :integer
  end
end
