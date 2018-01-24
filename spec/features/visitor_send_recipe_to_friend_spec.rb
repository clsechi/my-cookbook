require 'rails_helper'

feature 'Visitor send recipe to a friend' do
  scenario 'succesffuly' do
    user = create(:user)
    recipe = create(:recipe, title: 'Bolo', user: user)

    visit root_path
    click_on recipe.title
    fill_in 'Email', with: 'amigo@email.com'
    fill_in 'Mensagem', with: 'Essa receita é muito legal'

    expect(RecipesMailer).to receive(:share).with('amigo@email.com',
      'Essa receita é muito legal',
      recipe.id).and_call_original
    click_on 'Enviar'

    expect(page).to have_content('Receita enviada para amigo@email.com')
    expect(current_path).to eq recipe_path(recipe)
  end

  scenario 'another successfully scenario' do
    user = create(:user)
    recipe = create(:recipe, title: 'Bolo', user: user)

    visit root_path
    click_on 'Bolo'
    fill_in 'Email', with: 'amigo@email.com'
    fill_in 'Mensagem', with: 'Receita interessante'

    click_on 'Enviar'

    expect(page).to have_content('Receita enviada para amigo@email.com')
    expect(current_path).to eq recipe_path(recipe)
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to include 'amigo@email.com'
    expect(mail.subject).to eq 'Compartilharam uma receita com você'
    expect(mail.body).to include 'Receita interessante'
    expect(mail.body).to include recipe_url(recipe, host: 'localhost:3000')
    expect(mail.body).to include 'CookBook'
  end
end