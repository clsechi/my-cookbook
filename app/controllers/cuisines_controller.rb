class CuisinesController < ApplicationController

	def show
		@cuisine = Cuisine.find(params[:id])
		@recipes = Recipe.where(cuisine_id: @cuisine.id)
		@cuisines = Cuisine.all
		@recipe_types = RecipeType.all
	end

	def new
		@cuisine = Cuisine.new
	end

	def create
		@cuisine = Cuisine.new cuisine_params
		if @cuisine.valid?
			if @cuisine.save
				redirect_to @cuisine
			else
				puts "erro ao salvar dados"
			end
		else				
			render :new
		end
	end

	private

	def cuisine_params
		params.require(:cuisine).permit(:name)
	end

end