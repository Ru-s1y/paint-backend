class RegistrationsController < ApplicationController
  rescue_from UserAuth.not_found_exception_class, with: :not_found

  def create
    @user = User.new(
      name: user_params[:name],
      email: user_params[:email],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation]
    )

    if @user.save
      cookies[token_access_key] = cookie_token
      jwt_token = cookies[:access_token]
      response.headers['X-Authentication-Token'] = jwt_token
      render json: @user.my_json
    else
      render json: { status: 500, message: 'ユーザー登録に失敗しました。' }
    end
  end

  private
    # NotFoundエラー発生時にヘッダーレスポンスのみを返す
    # status => Rack::Utils::SYMBOL_TO_STATUS_CODE
    def not_found
      head(:not_found)
    end

    # トークンを発行する
    def auth
      @_auth ||= UserAuth::AuthToken.new(payload: { sub: entity.id })
    end

    # メールアドレスからアクティブなユーザーを返す => メールアドレスと一致するユーザーを返す
    def entity
      @_entity ||= User.find_by(email: user_params[:email])
    end

    # クッキーに保存するトークン
    def cookie_token
      {
        value: auth.token,
        expires: Time.at(auth.payload[:exp]),
        secure: Rails.env.production?,
        http_only: true
      }
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end