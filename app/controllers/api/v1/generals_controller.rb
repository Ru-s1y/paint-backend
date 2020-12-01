module Api
  module V1
    class GeneralsController < ApplicationController
      before_action :authenticate_user

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