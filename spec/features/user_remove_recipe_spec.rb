require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    # create data
    user = create(:user)
    cuisine = create(:cuisine, name: 'Paulista')
    recipe_type = create(:recipe_type, name: 'Massa')

    recipe = create(:recipe, title: 'Miojo', recipe_type: recipe_type,
                             cuisine: cuisine, user: user)

    another_recipe = create(:recipe, title: 'Macarrão',
                                     recipe_type: recipe_type,
                                     cuisine: cuisine, user: user)

    # simulate interaction
    login_as user
    visit root_path
    click_on recipe.title
    click_on 'Remover'

    expect(current_path). to eq(root_path)
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content(another_recipe.title)
    expect(page).to have_content('Receita removida com sucesso')
  end
end
