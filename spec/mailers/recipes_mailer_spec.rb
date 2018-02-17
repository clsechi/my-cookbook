require 'rails_helper'

RSpec.describe RecipesMailer, type: :mailer do
  describe 'share' do
    it 'should send the correct email' do
      recipe = create(:recipe)

      mail = RecipesMailer.share('carlos@email.com', 'some text', recipe.id)

      expect(mail.to).to include 'carlos@email.com'
      expect(mail.subject).to eq 'Compartilharam uma receita com você'
      expect(mail.from).to include 'no-reply@cookbook.com'
      expect(mail.body).to include 'some text'
      expect(mail.body).to include recipe_url(recipe)
      expect(mail.body).to include 'CookBook'
    end

    # add more tests
  end
end
