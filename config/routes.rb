Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :recipes, only: [:show, :new, :create, :edit, :update, :destroy]

  resources :cuisines, only: [:show, :new, :create]

  resources :recipe_types, only: [:show, :new, :create]

  get "/search" => "recipes#search", as: :search_recipe

end
