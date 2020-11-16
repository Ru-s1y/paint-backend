Rails.application.routes.draw do
  root to: "static#home"

  # ユーザー関連
  resources :registrations, only: [:create]
  # post :login, to: "sessions#login"
  # delete :logout, to: "sessions#logout"

  get :logged_in, to: "user_token#logged_in"
  post :login, to: "user_token#create"
  delete :logout, to: "user_token#destroy"
  post :guests, to: "guests#create"
  # resources :user_token, only: [:create] do
  #   delete :destroy, on: :collection
  # end
  
  # paint関連
  resources :albums
  get :my_albums, to: "albums#myindex"
  
  resources :pictures
  get :my_pictures, to: "pictures#myindex"
  get :album_pictures, to: "pictures#album_index"
  get :album_mypictures, to: "pictures#album_myindex"
  
    # ルーム関連
    # get :rooms, to: "rooms#index"
    # get :rooms_search, to: "rooms#search"
    # resources :rooms_registrations, only: [:create]
    # post :room_login, to: "rooms_sessions#login"
    # delete :room_logout, to: "rooms_sessions#logout"
  
    # メッセージ関連
    # resources :messages, only: [:index, :create, :destroy]
end