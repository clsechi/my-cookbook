require 'rails_helper'

feature 'Recipes with author' do
  scenario 'create a recipe' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, user: user)

    visit root_path
    click_on recipe.title

    expect(current_path). to eq(recipe_path(recipe))
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('p', text: "Enviado por: #{recipe.user.email}")
    expect(page).to have_css('p', text: "Cozinha: #{recipe.cuisine.name}")
  end

  scenario 'create a recipe in browser with author' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = build(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, user: user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: recipe.title
    select recipe.cuisine.name, from: 'Cozinha'
    select recipe.recipe_type.name, from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: recipe.difficulty
    fill_in 'Tempo de Preparo', with: recipe.cook_time
    fill_in 'Ingredientes', with: recipe.ingredients
    fill_in 'Como Preparar', with: recipe.method
    click_on 'Enviar'

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('p', text: "Enviado por: #{recipe.user.email}")
    expect(page).to have_css('p', text: "Cozinha: #{recipe.cuisine.name}")
  end
end
