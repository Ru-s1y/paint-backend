module Api
  module V1
    module Auth
      class UserTokenController < ApplicationController
        rescue_from UserAuth.not_found_exception_class, with: :not_found
        
        before_action :delete_cookie, except: [:logged_in]
        before_action :authenticate, only: [:create]
      
        # login
        def create
          # Cookieを設定
          cookies[token_access_key] = cookie_token
          # クッキーからアクセストークンを取得
          jwt_token = cookies[:access_token]
          response.headers['X-Authentication-Token'] = jwt_token
          render json: {
            exp: auth.payload[:exp],
            user: entity.my_json
          }
        end
      
        # logout
        def destroy
          # before_action :delete_cookie
          head(:ok)
        end
      
        # tokenがある時
        def logged_in
          if !current_user
            render json: {logged_in: false}
          else
            if current_user.guest == true
              render json: {
                logged_in: true,
                guest: true,
                user: current_user.my_json
              }
            else
              render json: {
                logged_in: true,
                guest: false,
                user: current_user.my_json
              }
            end
          end
        end
      
        private
      
          # NotFoundエラー発生時にヘッダーレスポンスのみを返す
          # status => Rack::Utils::SYMBOL_TO_STATUS_CODE
          def not_found
            head(:not_found)
          end
      
          # entityが存在しない、entityのパスワードが一致しない場合に404エラーを返す
          # メールアドレスに一致するユーザーがいない&パスワード一致しない時にRecordNotFoundエラーを出す
          def authenticate
            unless entity.present? && entity.authenticate(auth_params[:password])
              raise UserAuth.not_found_exception_class
            end
          end
      
          # トークンを発行する
          def auth
            @_auth ||= UserAuth::AuthToken.new(payload: { sub: entity.id })
          end
      
          # メールアドレスからアクティブなユーザーを返す => メールアドレスと一致するユーザーを返す
          def entity
            @_entity ||= User.find_by(email: auth_params[:email])
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
      
          def auth_params
            params.require(:user).permit(:email, :password)
          end
      end
    end
  end
end
