class RoomsSessionsController < ApplicationController

  before_action :current_user
  before_action :current_room

  # ログイン
  def login
    @room = Room.find_by(name: room_session_params[:name])

    if @room && @room.authenticate(room_session_params[:password])
      session[:room_id] = @room.id
      render json: {
        status: :created,
        room_logged_in: true,
        room: @room # password抜きで返したい。
      }
    else
      render json: { status: 401 }
    end
  end

  # ログアウト
  # 今のところいらない
  def logout
    reset_session
    render json: { status: 200, logged_out: true }
  end

  def logged_in_room
    if current_user && current_room
      render json: {
        room_logged_in: true,
        room_id: current_room.id
      }
    else
      render json: {
        room_logged_in: false
      }
    end
  end


  private
    def room_session_params
      params.require(:room).permit(:name, :password)
    end
end