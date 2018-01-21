class RecipesMailer < ApplicationMailer

	default from: 'no-reply@cookbook.com'

	def share(email, message, recipe_id)
    @message = message
    @recipe = Recipe.find(recipe_id)
    #chama funcão que envia email
    mail(to: email, subject: 'Compartilharam uma receita com você')
  end

end
