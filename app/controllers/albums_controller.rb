class AlbumsController < ApplicationController
  before_action :current_user
  before_action :set_album, only: [:show, :destroy, :update]
  # before_action :jwt_authenticate

  def index
    @albums = Album.where(publish: true)
    if @albums
      render 'index.json.jbuilder'
    else
      render json: @albums.error
    end
  end

  def myindex
    @albums = Album.where(user_id: params[:user_id])
    if @albums
      render 'index.json.jbuilder'
    else
      render json: @albums.error
    end
  end

  def show
    reder json: @album
  end

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
    @album.destroy
    render json: @destroy
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
      @album = Album.find(id: params[:id])
    end

    def album_params
      params.require(:abum).permit(:title, :description, :publish)
    end
end