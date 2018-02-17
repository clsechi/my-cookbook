require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do
    user = create(:user)

    login_as user
    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h2', text: 'Brasileira')
    expect(page).to have_content(
      'Nenhuma receita encontrada para este tipo de cozinha'
    )
  end

  scenario 'and must fill in name' do
    user = create(:user)

    login_as user
    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'do not register duplicated cuisine' do
    user = create(:user)
    create(:cuisine, name: 'Brasileira')

    login_as user
    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_content('Nome da Cozinha já está em uso')
  end
end
