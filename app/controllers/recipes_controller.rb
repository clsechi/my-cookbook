class RecipesController < ApplicationController

	before_action :set_cuisines_and_types, only: [:show, :new, :edit, :favorites, :index]

  before_action :set_recipe, only: [:show, :update, :destroy, :favorite, :unfavorite, :share] #:edit

	before_action :authenticate_user!, only: [:favorite, :new, :destroy] #:edit

	def index
		@recipes = Recipe.all
	end

	def show
	end

	def new 
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new recipe_params
		@recipe.user = current_user	
		if @recipe.save
			redirect_to @recipe
		else
			set_cuisines_and_types
			render :new
		end
	end

	def edit
		if current_user
			@recipe = Recipe.find(params[:id])
			render :edit	
		else
			redirect_to root_path
		end		
	end

	def update
		if @recipe.update recipe_params
			redirect_to @recipe
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
		if @recipe.destroy
			redirect_to root_path
			flash[:notice] = 'Receita removida com sucesso'
		end
	end

	def favorite
		current_user.favorites << @recipe
		redirect_to '/recipes/favorites'
	end

	def unfavorite
		FavoriteRecipe.find_by(recipe: @recipe, user: current_user).destroy
    redirect_to @recipe
	end

	def favorites
		@favorite_recipes = current_user.favorites
	end

	def share
    email = params[:email]
    msg = params[:message]

    #chama funcao do mailer que trata os parametros
    RecipesMailer.share(email, msg, @recipe.id).deliver_now

    flash[:notice] = "Receita enviada para #{email}"
    redirect_to @recipe
  end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :method, :photo, :featured)
	end

	def set_cuisines_and_types
		@cuisines = Cuisine.all
		@recipe_types = RecipeType.all
	end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end