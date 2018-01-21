class RecipesController < ApplicationController

	before_action :set_cuisines_and_types, only: [:show, :new, :edit, :user_favorite, :index]

	before_action :authenticate_user!, only: [:favorite] #:edit

	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new 
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new recipe_params
		@recipe.user = current_user	
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
		if current_user
			@recipe = Recipe.find(params[:id])
			render :edit	
		else
			redirect_to root_path
		end		
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

	def favorite
		recipe = Recipe.find(params[:id])
		current_user.favorites << recipe
		redirect_to :favorites
	end

	def user_favorite
		@favorite_recipes = current_user.favorites
	end

	def share
		@recipe = Recipe.find(params[:id])
    email = params[:email]
    msg = params[:message]

    #chama funcao do mailer que trata os parametros
    RecipesMailer.share(email, msg,
                        @recipe.id).deliver_now

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

end