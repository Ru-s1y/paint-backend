class RoomsRegistrationsController < ApplicationController
  def create
    room = Room.create!(
      username: params['room']['name'],
      password: params['room']['password'],
      password_confirmation: params['room']['password_confirmation']
    )

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