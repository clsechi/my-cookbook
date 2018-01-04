class RecipesController < ApplicationController

	def show
		id = params[:id]
		@recipe = Recipe.find(id)
	end

	def new 
		@recipe = Recipe.new
		@cuisines = Cuisine.all
	end

	def create
		@recipe = Recipe.new recipe_params
		if @recipe.save
			redirect_to @recipe
		else
			puts "erro ao salvar os dados"
		end
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :recipe_type, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
	end

end

