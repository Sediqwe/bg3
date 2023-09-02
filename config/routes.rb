Rails.application.routes.draw do
  resources :games
  get 'start/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "start#index"
end
