module Api
  module V1
    class AlbumsController < ApplicationController
      # before_action :current_user
      before_action :set_album, only: [:show, :destroy, :update]
      before_action :authenticate_user
    
      def index
        @albums = Album.where(publish: true)
        if @albums
          render 'index.json.jbuilder'
        else
          render json: @albums.error
        end
      end
    
      def myindex
        @albums = Album.where(user_id: current_user.id)
        if @albums
          render 'index.json.jbuilder'
        else
          render json: @albums.error
        end
      end

      def thumbnail
        @picture = Picture.find_by(album_id: params[:album_id])
        if @picture
          render json: @picture.image_path
        else
          render json: { message: 'null' }
        end
      end
    
      # def show
      #   reder json: @album
      # end
    
      def create
        @album = Album.create(
          title: params['album']['title'],
          description: params['album']['description'],
          publish: params['album']['publish'],
          user_id: current_user.id
        )
        if @album.save
          render json: @album
        else
          render json: @album.error
        end
      end
    
      def destroy
        @pictures = Picture.where(album_id: @album.id)
        if @pictures.present?
          @pictures.destroy_all
        end
    
        @album.destroy
        render json: {
          album: @album,
          pictures: @pictures
        }
      end
    
      def update
        if @album.update(album_params)
          render json: @album
        else
          render json: @album.error
        end
      end
    
      private
        def set_album
          @album = Album.find(params[:id])
        end
    
        def album_params
          params.require(:album).permit(:id, :title, :description, :publish)
        end
    end
  end
end