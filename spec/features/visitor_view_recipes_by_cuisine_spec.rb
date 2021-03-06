require 'rails_helper'

feature 'Visitor view recipes by cuisine' do
  scenario 'from home page' do
    # cria os dados necessarios previamente
    user = create(:user)
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, user: user, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços
                            pequenos, misture com o restante dos ingredientes')

    # simula a acao do usuario
    visit root_path
    click_on cuisine.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h2', text: cuisine.name)
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only cuisine recipes' do
    # cria os dados necessarios previamente
    user = create(:user)
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    dessert_recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura',
                  recipe_type: dessert_recipe_type,
                  cuisine: brazilian_cuisine, user: user, difficulty: 'Médio',
                  cook_time: 60, ingredients: 'Farinha, açucar, cenoura',
                  method: 'Cozinhe a cenoura, corte em pedaços
                            pequenos, misture com o restante dos
                            ingredientes')

    italian_cuisine = Cuisine.create(name: 'Italiana')
    main_recipe_type = RecipeType.create(name: 'Prato Principal')
    italian_recipe = Recipe.create(title: 'Macarrão Carbonara',
                                   recipe_type: main_recipe_type,
                                   cuisine: italian_cuisine, user: user,
                                   difficulty: 'Difícil',
                                   cook_time: 30,
                                   ingredients: 'Massa, ovos, bacon',
                                   method: 'Frite o bacon; Cozinhe a massa ate
                                    ficar al dent; Misture os ovos e o bacon a
                                     massa ainda quente;')
    # simula a acao do usuario
    visit root_path
    click_on italian_cuisine.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h3', text: italian_recipe.title)
    expect(page).to have_css('p', text: italian_recipe.recipe_type.name)
    expect(page).to have_css('p', text: italian_recipe.cuisine.name)
    expect(page).to have_css('p', text: italian_recipe.difficulty)
    expect(page).to have_css('p', text: "#{italian_recipe.cook_time} minutos")
  end

  scenario 'and cuisine has no recipe' do
    # cria os dados necessarios previamente
    user = create(:user)
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: brazilian_cuisine, user: user,
                           difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços
                            pequenos, misture com o restante dos ingredientes')

    italian_cuisine = Cuisine.create(name: 'Italiana')
    # simula a acao do usuario
    visit root_path
    click_on italian_cuisine.name

    # expectativas do usuario apos a acao
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de
                                   cozinha')
  end
end
