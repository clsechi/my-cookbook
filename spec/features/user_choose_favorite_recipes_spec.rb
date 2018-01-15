require 'rails_helper'

feature 'User choose favorite recipes' do
	scenario 'mark one recipe as favorite' do
		user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
     cuisine: cuisine, user: user)
    another_recipe = create(:recipe, title: 'Bolo de chocolate', recipe_type: recipe_type,
     cuisine: cuisine, user: user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'
    visit recipe_path(recipe)
    click_on 'Salvar como favorita'

    expect(page).to have_css('h1', text: 'Minhas Receitas Favoritas')
    expect(page).to have_content(recipe.title)
    expect(page).not_to have_content(another_recipe.title)
	end

	scenario 'mark more than one recipe as favorite' do
		user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
     cuisine: cuisine, user: user)
    another_recipe = create(:recipe, title: 'Bolo de chocolate', recipe_type: recipe_type,
     cuisine: cuisine, user: user)
    dont_show_recipe = create(:recipe, title: 'Torta', recipe_type: recipe_type,
     cuisine: cuisine, user: user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'
    visit recipe_path(recipe)
    click_on 'Salvar como favorita'
    visit recipe_path(another_recipe)
    click_on 'Salvar como favorita'

    expect(page).to have_css('h1', text: 'Minhas Receitas Favoritas')
    expect(page).to have_content(recipe.title)
    expect(page).to have_content(another_recipe.title)
    expect(page).not_to have_content(dont_show_recipe.title)

	end
end
