require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    # cria os dados necessarios
    user = create(:user)

    Cuisine.create(name: 'Arabe')
    RecipeType.create(name: 'Entrada')
    RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')

    # simula a acao do usuario
    login_as user
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h5', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('h5', text: 'Ingredientes')
    expect(page).to have_css('li', text: 'Trigo para quibe')
    expect(page).to have_css('li', text: 'salsinha')
    expect(page).to have_css('h5', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir.')
  end

  scenario 'and must fill in all fields' do
    user = create(:user)
    Cuisine.create(name: 'Arabe')
    # simula a acao do usuario
    login_as user
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'upload photo' do
    user = create(:user)
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')

    login_as user
    visit new_recipe_path

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    page.attach_file('Imagem da Receita', 'spec/support/files/arquivo.jpg')
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css("img[src*='arquivo.jpg']")
  end

  scenario 'user try upload invalid type' do
    user = create(:user)
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')

    login_as user
    visit new_recipe_path

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    page.attach_file('Imagem da Receita', 'spec/support/files/file.pdf')
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
    expect(page).to have_content('Imagem da Receita não é válido')
  end

  scenario 'user create recipe as featured' do
    user = create(:user)
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')

    login_as user
    visit new_recipe_path

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    page.attach_file('Imagem da Receita', 'spec/support/files/arquivo.jpg')
    check 'Destaque'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css("img[src*='star.png']")
  end

  scenario 'recipe details show featured' do
    recipe = create(:recipe, title: 'Tabule', featured: true)

    visit recipe_path(recipe)

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css("img[src*='star.png']")
  end

  scenario 'create a recipe with author' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = build(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: cuisine, user: user)

    login_as user
    visit root_path
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
