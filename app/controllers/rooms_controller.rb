class RoomsController < ApplicationController
  before_action :current_user

  include Pagination

  def index
    @rooms = Room.all.page(params[:page]).per(10)
    @pagination = resources_with_pagination(@rooms)
    render 'rooms/index.json.jbuilder'
  end
end