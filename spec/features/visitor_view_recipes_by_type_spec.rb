
require 'rails_helper'

feature 'Visitor view recipes by type' do

  scenario 'from home page' do
    # cria os dados necessários previamente
    user = create(:user)
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, user: user, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    visit root_path
    click_on recipe_type.name

    # expectativas do usuário após a ação
    expect(page).to have_css('h2', text: recipe_type.name)
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only recipes from same type' do
    # cria os dados necessários previamente
    user = create(:user)
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    dessert_recipe_type = RecipeType.create(name: 'Sobremesa')
    dessert_recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: dessert_recipe_type,
                                   cuisine: brazilian_cuisine, user: user, difficulty: 'Médio',
                                   cook_time: 60,
                                   ingredients: 'Farinha, açucar, cenoura',
                                   method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    italian_cuisine = Cuisine.create(name: 'Italiana')
    main_recipe_type = RecipeType.create(name: 'Prato Principal')
    main_recipe = Recipe.create(title: 'Macarrão Carbonara', recipe_type: main_recipe_type,
                                cuisine: italian_cuisine, user: user, difficulty: 'Difícil',
                                cook_time: 30, ingredients: 'Massa, ovos, bacon',
                                method: 'Frite o bacon; Cozinhe a massa ate ficar al dent; Misture os ovos e o bacon a massa ainda quente;')
    # simula a ação do usuário
    visit root_path
    click_on main_recipe_type.name

    # expectativas do usuário após a ação
    expect(page).to have_css('h3', text: main_recipe.title)
    expect(page).to have_css('p', text: main_recipe.recipe_type.name)
    expect(page).to have_css('p', text: main_recipe.cuisine.name)
    expect(page).to have_css('p', text: main_recipe.difficulty)
    expect(page).to have_css('p', text: "#{main_recipe.cook_time} minutos")
    expect(page).not_to have_css('p', text: dessert_recipe.title)
    expect(page).not_to have_css('p', text: dessert_recipe.recipe_type.name)
    expect(page).not_to have_css('p', text: dessert_recipe.cuisine.name)
    expect(page).not_to have_css('p', text: dessert_recipe.difficulty)
    expect(page).not_to have_css('p', text: "#{dessert_recipe.cook_time} minutos")

  end

  scenario 'and type has no recipe' do
    # cria os dados necessários previamente
    user = create(:user)
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: brazilian_cuisine, user: user, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    main_dish_type = RecipeType.create(name: 'Prato Principal')
    # simula a ação do usuário
    visit root_path
    click_on main_dish_type.name

    # expectativas do usuário após a ação
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de receitas')
  end
end
