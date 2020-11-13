class SessionsController < ApplicationController
  # include JwtAuthenticator
  # before_action :jwt_authenticate, only: [:logged_in]
  before_action :current_user

  def login
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      # session[:user_id] = @user.id
      # jwt_token = encode(@user.id)
      # response.headers['X-Authentication-Token'] = jwt_token
      render json: {
        status: :created,
        logged_in: true,
        user: @user.my_json
      }
    else
      # raise UnableAuthorizationError.new("ログインに失敗しました。")
      render json: { status: 401 }
    end
  end

  def logout
    reset_session
    render json: { status: 200, logged_out: true }
  end

  def logged_in
    if current_user
      render json: {
        logged_in: true,
        user: current_user
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  private
    def session_params
      params.require(:user).permit(:email, :password)
    end
end