Rails.application.routes.draw do
  resources :blogs
  get "users", to: "users#index"
  resources :lines
  resources :uploads
  resources :games
  get "gameindex",to: "uploads#gameindex"
  get "user", to: "users#index"
  post "users", to: "users#create"
  get "userslist", to: "users#userslist"
  get "/user/new", to: "users#new"
  patch "/user", to: "users#update"
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
