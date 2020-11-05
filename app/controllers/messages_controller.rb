class MessagesController < ApplicationController
  before_action :current_user
  before_action :current_room

  def index
    @messages = Message.where(room_id: current_room.id)
    if @messages
      render json: @messages
    else
      render json: { status: 200, message: 'Message is not exist!' }
    end
  end

  def create
    @message = Message.create!(
      message: params[:message],
      room_id: current_room.id,
      user_id: current_room.id
    )
    if @message
      render json: {
        status: :created,
        message: @message
      }
    else
      render json: @room.error
    end
  end

  def destroy
    @message = Message.find(parmas[:id])
    @message.destroy
    render json: @message
  end
end