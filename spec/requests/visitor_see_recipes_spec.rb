require 'rails_helper'

describe 'visitor see recipes via API', type: :request do
  it 'successfully' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipes = create_list(:recipe, 6, recipe_type: recipe_type,
                                      cuisine: cuisine, user: user)

    get api_recipes_url

    json = JSON.parse(response.body)

    expect(response.status).to eq 200

    json.zip(recipes).each do |reply, recipe|
      expect(reply['title']).to eq(recipe.title)
    end
  end
end
