require 'rails_helper'

feature 'User sign in' do
  scenario 'using an email and a password' do
    user = create(:user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'

    expect(page).to have_content("Bem-vindo #{user.email}")
    expect(page).not_to have_button('Entrar')
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
    expect(page).to have_button('Entrar')
  end

  scenario 'and edit profile' do
    user = create(:user)

    login_as(user)
    visit edit_user_path(user)
    fill_in 'Nome', with: 'Romario'
    fill_in 'Cidade', with: 'Ibiza'
    fill_in 'E-mail', with: 'romario@google.com'
    # fill_in 'Senha', with: user.password
    fill_in 'Facebook', with: 'facebook.com/romario1'
    click_on 'Enviar'

    expect(page).to have_css('p', text: 'Romario')
    expect(page).to have_css('p', text: 'Ibiza')
    expect(page).to have_css('p', text: 'romario@google.com')
    expect(page).to have_css('p', text: 'facebook.com/romario1')
  end
end
