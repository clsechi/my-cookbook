class AddRecipesRefToFavoriteRecipes < ActiveRecord::Migration[5.1]
  def change
    add_reference :favorite_recipes, :recipe, foreign_key: true
  end
end
