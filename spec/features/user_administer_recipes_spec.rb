require 'rails_helper'

feature 'User administer your recipes' do
  scenario 'see the edit button of your own recipes' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, user: user)

    login_as user
    visit recipe_path(recipe)

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_link('Editar')
  end

  scenario 'another user do not see edit button' do
    user = create(:user)
    another_user = create(:user, email: 'cat@gmail.com')
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, user: user)

    login_as another_user
    visit recipe_path(recipe)

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_link('Editar')
  end

  scenario 'not owner access edit route' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, user: user)

    visit edit_recipe_path(recipe)

    expect(current_path).to eq(root_path)
  end

  scenario 'user do not see edit button without login' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, user: user)

    visit recipe_path(recipe)

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_link('Editar')
  end
end
