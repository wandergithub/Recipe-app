Rails.application.routes.draw do
  devise_for :users
  get 'shopping_list/:recipe_id', to: 'recipes#shopping_list'
  get 'public_recipes', to: 'recipes#public'
  get 'recipe_foods/:recipe_id', to: 'recipe_foods#new'
  post 'recipe_foods/:recipe_id', to: 'recipe_foods#create'
  resources :recipe_foods, only: [:destroy, :update, :edit]
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :foods, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Add root route
  root to: "foods#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :foods, only: [:index, :create, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
