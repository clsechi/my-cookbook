Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :recipes, only: [:show, :new, :create, :edit, :update, :destroy, :index] do
  	collection do
      get 'search'
      get 'favorites'
    end 
    member do 
  		post 'share'
      post 'favorite'
      delete 'unfavorite'
  	end
  end

  resources :cuisines, only: [:show, :new, :create, :edit, :update]

  resources :recipe_types, only: [:show, :new, :create, :edit, :update]

  resources :users, only: [:show, :edit, :update, :index] do
    get 'recipes'
  end
end
