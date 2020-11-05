class MessagesController < ApplicationController
  before_action :current_user
  before_action :current_room

  def index
    # @messages = Message.where(room_id: current_room.id)
    @messages = Message.where(room_id: params[:room_id])
    if @messages
      render json: @messages
    else
      render json: { status: 200, warning: 'Message is not exist!' }
    end
  end

  def create
    @message = Message.create!(
      message: message_params[:message],
      room_id: message_params[:room_id],
      user_id: current_user.id
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

  private
    def message_params
      params.require(:message).permit(:room_id, :message)
    end
end