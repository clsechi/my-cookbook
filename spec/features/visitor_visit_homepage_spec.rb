require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('a', text: 'CookBook')
    expect(page).to have_css('h2', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    user = create(:user)    
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                          cuisine: cuisine, user: user, difficulty: 'Médio', 
                          ingredients: 'Cenoura, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('span', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    user = create(:user)
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                          cuisine: cuisine, user: user, difficulty: 'Médio',
                          ingredients: 'Cenoura, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60)

    another_recipe_type = RecipeType.create(name: 'Prato Principal')
    another_recipe = Recipe.create(title: 'Feijoada', recipe_type: another_recipe_type,
                          cuisine: cuisine, user: user, difficulty: 'Difícil',
                          ingredients: 'Feijao, paio, carne seca',
                          method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
                          cook_time: 90)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('span', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('span', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and view most favorites' do
    user = create(:user)
    user2 = create(:user, email: 'cris@email.com')
    user3 = create(:user, email: 'julius@email.com')
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipes = create_list(:recipe, 3, user: user, cuisine: cuisine, recipe_type: recipe_type)
    do_not_show_recipe = create(:recipe, title: 'Miojo', user: user, cuisine: cuisine, recipe_type: recipe_type)
    #3 favoritos
    FavoriteRecipe.create(recipe_id: recipes[0].id, user_id: user.id)
    FavoriteRecipe.create(recipe_id: recipes[0].id, user_id: user2.id)
    FavoriteRecipe.create(recipe_id: recipes[0].id, user_id: user3.id)
    #2 favoritos
    FavoriteRecipe.create(recipe_id: recipes[1].id, user_id: user.id)
    FavoriteRecipe.create(recipe_id: recipes[1].id, user_id: user2.id)
    #1 favorito
    FavoriteRecipe.create(recipe_id: recipes[2].id, user_id: user.id)

    visit root_path

    expect(page).to have_content('Favoritas dos Usuários')
    within('div.favorites') do
      recipes.each do |rec|      
        expect(page).to have_css('span', text: rec.title)
      end
    end
    expect(page).not_to have_css('favorites#span', text: do_not_show_recipe.title)
  end
end
