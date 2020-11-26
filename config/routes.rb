Rails.application.routes.draw do
  root to: "static#home"
  
  namespace :api do
    namespace :v1 do
      namespace :auth do
        # ユーザー関連
        resources :registrations, only: [:create]
        get :logged_in, to: "user_token#logged_in"
        post :login, to: "user_token#create"
        delete :logout, to: "user_token#destroy"
        post :guests, to: "guests#create"
        # resources :users, only: [:destroy, :edit] # 実装は後
      end
    
      # paint関連
      resources :albums, only: [:index, :create, :update, :destroy]
      get :my_albums, to: "albums#myindex"
      get :search_albums, to: "albums#search_albums"
      
      resources :pictures, only: [:index, :create, :update, :destroy]
      get :my_pictures, to: "pictures#myindex"
      get :album_pictures, to: "pictures#album_index"
      get :album_mypictures, to: "pictures#album_myindex"
      get :search_pictures, to: "pictures#search_pictures"
      get :thumbnail, to: "albums#thumbnail"

      # favorite picture
      get :favo_pictures_index, to: "favorite_pictures#index"
      get :favo_confirm_picture, to: "favorite_pictures#favo_confirm"
      post :favo_on_picture, to: "favorite_pictures#create"
      delete :favo_off_picture, to: "favorite_pictures#destroy"

      # favorite album
      get :favo_albums_index, to: "favorite_albums#index"
      get :favo_confirm_album, to: "favorite_albums#favo_confirm"
      post :favo_on_album, to: "favorite_albums#create"
      delete :favo_off_album, to: "favorite_albums#destroy"
    end
  end
end