class RoomsController < ApplicationController
  before_action :current_user

  include Pagination

  def index
    @rooms = Room.all.page(params[:page]).per(10)
    @pagination = resources_with_pagination(@rooms)
    render 'index.json.jbuilder'
    # render json: rooms: @rooms.to_json(except: [:password_digest], include: {user: {only: :name}})
  end

  def search
    @rooms = Room.search(params[:search]).limit(5)
    render json: @rooms.to_json(except: [:password_digest])
  end

  private
    def search_params
      params.require(:search).permit!
    end
end