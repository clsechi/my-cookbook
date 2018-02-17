require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = create(:user)

    arabian_cuisine = Cuisine.create(name: 'Arabe')
    Cuisine.create(name: 'Brasileira')

    RecipeType.create(name: 'Entrada')
    main_type = RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')

    Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                  cuisine: arabian_cuisine, user: user,
                  difficulty: 'Médio',
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  method: 'Cozinhe a cenoura, corte em pedaços
                             pequenos, misture com o restante dos ingredientes')

    # simula a acao do usuario
    login_as user
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Brasileira', from: 'Cozinha'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e
                                   chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h5', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('li', text: 'Cenoura')
    expect(page).to have_css('li', text: 'farinha')
    expect(page).to have_css('li', text: 'ovo')
    expect(page).to have_css('li', text: 'chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura')
  end

  scenario 'and all fields must be filled' do
    user = create(:user)

    arabian_cuisine = Cuisine.create(name: 'Arabe')
    Cuisine.create(name: 'Brasileira')

    RecipeType.create(name: 'Entrada')
    main_type = RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')

    Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                  cuisine: arabian_cuisine, user: user,
                  difficulty: 'Médio',
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  method: 'Cozinhe a cenoura, corte em pedaços
                            pequenos, misture com o restante dos ingredientes')

    # simula a acao do usuario
    login_as user
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
