Rails.application.routes.draw do
  root to: "static#home"

  resources :registrations, only: [:create]
  
  post :login, to: "sessions#login"
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

  post :room_login, to: "rooms_sessions#login"
  delete :room_logout, to: "rooms_sessions#logout"

  resources :rooms_registrations, only: [:create]
end