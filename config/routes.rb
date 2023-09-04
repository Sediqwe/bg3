Rails.application.routes.draw do
  get "users", to: "users#index"
  resources :lines
  resources :uploads
  resources :games
  get "login", to:"session#new"
  get "logout", to:"session#destroy"
  post "/session/create"
  get "linegood", to: "lines#good"
  get "linebad", to: "lines#bad"
  get "linedelete", to: "lines#delete"
  get "download", to: "uploads#download"
  get 'start/index'
  get 'readxml', to: "uploads#readxml"
  root "start#index"
end
