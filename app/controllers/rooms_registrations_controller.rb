class RoomsRegistrationsController < ApplicationController
  before_action :current_user
  
  def create
    if params['room']['publish'] === false
      room = Room.create!(
        name: params['room']['name'],
        description: params['room']['description'],
        publish: params['room']['publish'],
        password: params['room']['password'],
        password_confirmation: params['room']['password_confirmation'],
        user_id: current_user.id
      )
    else
      room = Room.create!(
        name: params['room']['name'],
        description: params['room']['description']
        user_id: current_user.id
      )
    end

    if user
      session[:user_id] = user.id
      render json: {
        status: :created,
        user: user
      }
    else
      render json: { status: 500 }
    end
  end
end