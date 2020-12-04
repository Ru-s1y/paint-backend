module Api
  module V1
    class GeneralsController < ApplicationController
      before_action :authenticate_user

      # Home画面用の一覧表示(件数制限)
      def index
        @albums = Album.where(publish: true).order(created_at: :DESC).limit(5)
        @pictures = Picture.where(publish: true).order(created_at: :DESC).limit(5)
        render 'index.json.jbuilder'
      end

      # Mypage用の一覧表示(件数制限)
      def my_index
        @albums = Album.where(user_id: current_user.id).order(created_at: :DESC).limit(5)
        @pictures = Picture.where(user_id: current_user.id).order(created_at: :DESC).limit(5)
        render 'index.json.jbuilder'
      end

      def count_index
        @pictures = Picture.where(user_id: current_user.id)
        @pictures_count = @pictures.count
        @albums = Album.where(user_id: current_user.id)
        @albums_count = @albums.count
        render 'count_index.json.jbuilder'
      end
    end
  end
end