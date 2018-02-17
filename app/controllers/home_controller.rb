class HomeController < ApplicationController
  def index
    @recipes = Recipe.last(6)
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all

    fav_recipes = FavoriteRecipe.joins(:recipe)
                                .group(:recipe)
                                .count.sort.max_by(3) { |_recipe, quant| quant }

    @most_favorites = []

    fav_recipes.each do |rec|
      @most_favorites << rec[0]
    end
  end
end
