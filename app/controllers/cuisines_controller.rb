class CuisinesController < ApplicationController

	def show
		@cuisine = Cuisine.find(params[:id])
		@recipes = Recipe.where(cuisine_id: @cuisine.id)
	end

	def new
		@cuisine = Cuisine.new
	end

	def create
		@cuisine = Cuisine.new cuisine_params
		if @cuisine.name.blank?
			render "error_add_cuisine"
		else				
			if @cuisine.save
				redirect_to @cuisine
			else
				puts "erro ao salvar dados"
			end
		end
	end

	private

	def cuisine_params
		params.require(:cuisine).permit(:name)
	end

end