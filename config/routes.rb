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
      end
    
      # paint関連
      resources :albums
      get :my_albums, to: "albums#myindex"
      
      resources :pictures
      get :my_pictures, to: "pictures#myindex"
      get :album_pictures, to: "pictures#album_index"
      get :album_mypictures, to: "pictures#album_myindex"
      get :thumbnail, to: "albums#thumbnail"
    end
  end
end