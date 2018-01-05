class RecipesController < ApplicationController

	def show
		id = params[:id]
		@recipe = Recipe.find(id)
	end

	def new 
		@recipe = Recipe.new
		@cuisines = Cuisine.all
		@recipe_types = RecipeType.all
	end

	def create
		@recipe = Recipe.new recipe_params
		if @recipe.valid?
			if @recipe.save
				redirect_to @recipe
			else
				puts "erro ao salvar os dados"
			end
		else
			@cuisines = Cuisine.all
			@recipe_types = RecipeType.all
			render :new
		end		
	end

	def edit
		@recipe = Recipe.find(params[:id])
		@cuisines = Cuisine.all
		@recipe_types = RecipeType.all
		render :edit
	end

	def update
		#nao esta recebendo o objeto
		@recipe = Recipe.find(params[:id])
		if @recipe.update recipe_params
			redirect_to @recipe
		elsif @recipe.valid?
			puts "erro ao salvar os dados"
		else			
			@cuisines = Cuisine.all
			@recipe_types = RecipeType.all
			render :new
		end
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
	end

end

