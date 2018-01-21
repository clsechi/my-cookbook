class AddUsersRefToFavoriteRecipes < ActiveRecord::Migration[5.1]
  def change
    add_reference :favorite_recipes, :user, foreign_key: true
  end
end
