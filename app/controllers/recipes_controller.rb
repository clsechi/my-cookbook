class RecipesController < ApplicationController

	def show
		id = params[:id]
		@recipe = Recipe.find(id)
	end

	def new 
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new recipe_params
		if @recipe.save
			redirect_to @recipe
		end
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :recipe_type, :cuisine, :difficulty, :cook_time, :ingredients, :method)
	end

end

