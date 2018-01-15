require 'rails_helper'

feature 'User see last recipes on home' do
	scenario 'see last recipes' do
		user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipes = Array.new()

    for i in 0..8
    	recipes[i] = create(:recipe, title: "Bolo #{i}", recipe_type: recipe_type,
     cuisine: cuisine, user: user)
    end

    visit root_path

    expect(page).to have_css('h2', text: 'Últimas Receitas')

    for i in 3..8
    	expect(page).to have_content(recipes[i].title)
  	end
   
    expect(page).not_to have_content(recipes[0].title)
    expect(page).not_to have_content(recipes[1].title)

	end

	scenario 'see all recipes' do
		user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipes = Array.new()

    for i in 0..8
    	recipes[i] = create(:recipe, title: "Bolo #{i}", recipe_type: recipe_type,
     cuisine: cuisine, user: user)
    end

    visit root_path
    click_on "Todas as Receitas"

    expect(page).to have_css('h1', text: 'Receitas')

    for i in 0..8
    	expect(page).to have_content(recipes[i].title)
  	end
	end
end