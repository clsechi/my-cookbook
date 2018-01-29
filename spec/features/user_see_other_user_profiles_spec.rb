require 'rails_helper'

feature 'User see other user profiles' do
  scenario 'sucessfully' do
    user = create(:user, email: 'user@email.com')
    another_user = create(:user, email: 'another_user@email.com')

    login_as user
    visit root_path
    click_on 'Usuários'

    expect(page).to have_css('p', text: user.email)
    expect(page).to have_css('p', text: another_user.email)
    expect(page).to have_css('p', text: 'Receitas cadastradas: 0')
  end

  scenario 'see user recipes' do
    user = create(:user, email: 'user@email.com', name: 'Renato')
    another_user = create(:user, email: 'another_user@email.com')
    recipe = create(:recipe, title: 'Miojo', user: user)

    login_as(user)
    visit root_path
    click_on 'Usuários'
    click_on user.name

    expect(current_path).to eq(user_recipes_path(user))
    expect(page).to have_css('h1', text: "Receitas de #{user.name}")
    expect(page).to have_link(recipe.title)
    expect(page).not_to have_content(another_user.email)
  end
end