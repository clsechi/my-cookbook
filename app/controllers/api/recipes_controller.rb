module Api
  class RecipesController < ApiController

    def index
      recipes = Recipe.all
      render json: recipes.to_json, status: :ok
    end

  end
end
