class RecipesController < ApplicationController

	before_action :set_cuisines_and_types, only: [:show, :new, :edit]

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new 
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new recipe_params		
		if @recipe.save
			redirect_to @recipe
		elsif @recipe.valid?
			puts "erro ao salvar os dados"
		else
			set_cuisines_and_types
			render :new
		end		
	end

	def edit
		@recipe = Recipe.find(params[:id])
		render :edit
	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update recipe_params
			redirect_to @recipe
		elsif @recipe.valid?
			puts "erro ao salvar os dados"
		else			
			set_cuisines_and_types
			render :new
		end
	end

	def search
		@recipe_name = params[:busca]
		@recipes = Recipe.where "title like ?", "%#{@recipe_name}%"
	end

	def destroy
		recipe = Recipe.find(params[:id])
		if recipe.destroy
			redirect_to root_path
			flash[:notice] = 'Receita removida com sucesso'
		else
			puts "erro ao deletar dados"
		end
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
	end

	def set_cuisines_and_types
		@cuisines = Cuisine.all
		@recipe_types = RecipeType.all
	end

end