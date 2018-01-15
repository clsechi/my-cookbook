class HomeController < ApplicationController 
	def index
		@recipes = Recipe.last(6)
		@cuisines = Cuisine.all
		@recipe_types = RecipeType.all
	end
end