Rails.application.routes.draw do
  resources :lines
  resources :uploads
  resources :users
  resources :games
  get 'start/index'
  get 'readxml', to: "uploads#readxml"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "start#index"
end
