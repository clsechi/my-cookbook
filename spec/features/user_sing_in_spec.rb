require 'rails_helper'

feature 'User sign in' do
  scenario 'using an email and a password' do
    user = User.create(email: 'carlos@email.com', password: 'pass1234')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'


    expect(page).to have_content("Bem-vindo #{user.email}")
    expect(page).not_to have_link('Entrar')
  end

  scenario 'user logout' do
    user = User.create(email: 'carlos@email.com', password: 'pass1234')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'
    click_on 'Sair'

    expect(page).not_to have_content("Bem-vindo #{user.email}")
    expect(page).to have_link('Entrar')
  end
end
