require 'rails_helper'

feature 'Visitor search for recipes' do
  scenario 'from home page' do
    # cria os dados necessarios previamente
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    another_recipe_type = create(:recipe_type, name: 'Entrada')

    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, user: user, difficulty: 'Médio',
                             cook_time: 60,
                             ingredients: 'Farinha, açucar, cenoura')

    another_recipe = create(:recipe, title: 'Salada de cenoura',
                                     recipe_type: another_recipe_type,
                                     cuisine: cuisine, user: user,
                                     difficulty: 'Facil',
                                     cook_time: 60,
                                     ingredients: 'Cenoura e legumes')

    # simula a acao do usuario
    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'

    # expectativas do usuario apos a acao
    expect(page)
      .to have_css('h2', text: 'Resultado da busca por: Bolo de cenoura')
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'and navigate to recipe details' do
    # cria os dados necessarios previamente
    recipe = create(:recipe, title: 'Bolo de cenoura')

    # simula a acao do usuario
    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'
    click_on 'Bolo de cenoura'

    # expectativas do usuario apos a acao
    expect(current_path).to eq(recipe_path(recipe))
  end
end
