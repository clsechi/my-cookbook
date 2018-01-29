require 'rails_helper'

feature 'User edit recipe type' do
  scenario 'sucessfully' do
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Sobresa')

    visit edit_recipe_type_path(recipe_type)
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h2', text: 'Sobremesa')
    expect(page).not_to have_content('Sobresa')
  end

  scenario 'do not duplicate a recipe type' do
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    another_recipe_type = create(:recipe_type, name: 'Entrada')

    visit edit_recipe_type_path(recipe_type)
    fill_in 'Nome', with: 'Entrada'
    click_on 'Enviar'

    expect(page).to have_content('Tipo da Receita já está em uso')
  end
end