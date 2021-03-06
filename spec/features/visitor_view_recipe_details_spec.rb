require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'successfully' do
    # cria os dados necessarios
    user = create(:user)
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, user: user, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura,
                            corte em pedaços pequenos,
                            misture com o restante dos ingredientes')

    # simula a acao do usuario
    visit root_path
    click_on recipe.title

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('h5', text: 'Detalhes')
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")
    expect(page).to have_css('h5', text: 'Ingredientes')
    ingredients = recipe.ingredients.split(',')
    ingredients.each do |ing|
      expect(page).to have_css('li', text: ing.strip)
    end
    expect(page).to have_css('h5', text: 'Como Preparar')
    expect(page).to have_css('p', text: recipe.method.gsub('  ', '')
                                                     .tr("\n", ' '))
  end

  scenario 'and return to recipe list' do
    # cria os dados necessarios
    user = create(:user)
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type:  recipe_type,
                           cuisine: cuisine, user: user, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços
                            pequenos, misture com o restante dos ingredientes')

    # simula a acao do usuario
    visit root_path
    click_on recipe.title
    click_on 'Voltar'

    # expectativa da rota atual
    expect(current_path).to eq(root_path)
  end
end
