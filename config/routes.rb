Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :recipes, only: [:show, :new, :create, :edit, :update, :destroy, :index] do
  	member do 
  		post 'share'
  	end
  end

  resources :cuisines, only: [:show, :new, :create]

  resources :recipe_types, only: [:show, :new, :create]

  get '/search' => 'recipes#search', as: :search_recipe

  post '/favorite/:id' => 'recipes#favorite', as: :favorite_recipe

  get '/favorites' => 'recipes#user_favorite'

end
