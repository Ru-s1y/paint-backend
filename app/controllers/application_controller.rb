class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, railse: false
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_room
    @current_room ||= Room.find(session[:room_id]) if session[:room_id]
  end
end
