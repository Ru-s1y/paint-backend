module Api
  module V1
    class AlbumsController < ApplicationController
      include Pagination
      before_action :set_album, only: [:show, :destroy, :update]
      before_action :authenticate_user
    
      # 公開アルバム一覧
      def index
        @albums = Album.where(publish: true).order(updated_at: :DESC).page(params[:page]).per(6)
        pagenation = resources_with_pagination(@albums)
        if @albums
          render 'paginate.json.jbuilder'
        else
          render json: @albums.error
        end
      end
    
      # マイアルバム一覧
      def myindex
        @albums = Album.where(user_id: current_user.id).order(updated_at: :DESC).page(params[:page]).per(6)
        pagenation = resources_with_pagination(@albums)
        if @albums
          render 'paginate.json.jbuilder'
        else
          render json: @albums.error
        end
      end

      # アルバムリスト用
      def album_list
        @albums = Album.where(user_id: current_user.id).order(updated_at: :DESC)
        if @albums
          render 'albumlist.json.jbuilder'
        else
          render json: @albums.error
        end
      end

      # アルバムサムネイル取得
      def thumbnail
        @picture = Picture.find_by(album_id: params[:album_id])
        if @picture
          render json: @picture.image_path
        else
          render json: { message: 'null' }
        end
      end

      # アルバム検索用
      def search_albums
        @albums = Album.search(params[:search]).limit(20)
        if @albums
          render 'index.json.jbuilder'
        else
          render json: { message: 'not found' }
        end
      end

      # マイアルバム検索用
      def search_myalbums
        @albums = Album.mysearch(params[:search], current_user).limit(20)
        if @albums
          render 'index.json.jbuilder'
        else
          render json: {message: 'not found'}
        end
      end
    
      # アルバム作成
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
    
      # アルバム削除
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
    
      # アルバム編集
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