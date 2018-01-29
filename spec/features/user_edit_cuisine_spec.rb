require 'rails_helper'

feature 'User edit cuisine' do
  scenario 'sucessfully' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Japoesa')

    visit edit_cuisine_path(cuisine)
    fill_in 'Nome', with: 'Japonesa'
    click_on 'Enviar'

    expect(page).to have_css('h2', text: 'Japonesa')
    expect(page).not_to have_content('Japoesa')
  end

  scenario 'do not duplicate a cuisine' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    another_cuisine = create(:cuisine, name: 'Italiana')

    visit edit_cuisine_path(cuisine)
    fill_in 'Nome', with: 'Italiana'
    click_on 'Enviar'

    expect(page).to have_content('Nome da Cozinha já está em uso')
  end
end