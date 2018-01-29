class CuisinesController < ApplicationController
  
  before_action :set_cuisines_and_types, only: [:show]

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = Recipe.where(cuisine_id: @cuisine.id)
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new cuisine_params
    if @cuisine.save
      redirect_to @cuisine
    else
      render :new
    end
  end

  def edit
    @cuisine = Cuisine.find(params[:id])
  end

  def update
    @cuisine = Cuisine.find(params[:id])
    if @cuisine.update cuisine_params
      redirect_to @cuisine
    else
      render :edit
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

  def set_cuisines_and_types
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end
end