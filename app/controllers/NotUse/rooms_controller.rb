class RoomsController < ApplicationController
  before_action :current_user

  include Pagination

  def index
    @rooms = Room.all.page(params[:page]).per(10)
    @pagination = resources_with_pagination(@rooms)
    render 'index.json.jbuilder'
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