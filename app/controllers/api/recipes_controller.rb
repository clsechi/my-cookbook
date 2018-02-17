module Api
  class RecipesController < ApiController
    def index
      recipes = Recipe.all
      json = { recipes: recipes.as_json(except: [:created_at, :updated_at,
                                              :photo_file_name,
                                              :photo_content_type,
                                              :photo_file_size,
                                              :photo_updated_at])}
      render json: json, status: :ok
    end
  end
end
