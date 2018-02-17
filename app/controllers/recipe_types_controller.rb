class RecipeTypesController < ApplicationController
  before_action :set_cuisines_and_types, only: [:show]

  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def show
    @recipe_type = RecipeType.find(params[:id])
    @recipes = Recipe.where(recipe_type_id: @recipe_type.id)
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new recipe_type_params
    if @recipe_type.save
      redirect_to @recipe_type
    else
      render :new
    end
  end

  def edit
    @recipe_type = RecipeType.find(params[:id])
  end

  def update
    @recipe_type = RecipeType.find(params[:id])
    if @recipe_type.update recipe_type_params
      redirect_to @recipe_type
    else
      render :edit
    end
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end

  def set_cuisines_and_types
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end
end
