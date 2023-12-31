Rails.application.routes.draw do
  resources :lexicons
  resources :images
  root "start#index"

  resources :blogs
  resources :lines
  resources :uploads
  resources :games
  
  get "translatecopy", to: "lines#translatecopy"
  get "linegood", to: "lines#good"
  get "linebad", to: "lines#bad"
  get "linedelete", to: "lines#delete"
  
  
  get "users", to: "users#index"
  get "user", to: "users#index"
  post "users", to: "users#create"
  get "userslist", to: "users#userslist"
  get "/user/new", to: "users#new"
  patch "/user", to: "users#update"
  delete "/user", to: "users#destroy"

  get "search", to: "images#search"
  get "imagelineadd", to: "images#imageline"
  delete "/imagelineremove", to: "images#imagelineremove"
  
  get "login", to:"session#new"
  get "logout", to:"session#destroy"
  post "/session/create"
  
  
  get "active", to: "uploads#active"
  get "gameindex",to: "uploads#gameindex"
  get "download", to: "uploads#download"
  get 'readxml', to: "uploads#readxml"
  
end
