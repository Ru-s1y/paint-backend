require 'securerandom'
module Api
  module V1
    module Auth
      class GuestsController < ApplicationController
        rescue_from UserAuth.not_found_exception_class, with: :not_found
      
        def create
          @pass = random_string(16)
          @mail = "#{random_string(6)}@#{random_string(6)}.com"
          @mail = @mail.downcase
          @user = User.new(
            name: "ゲストユーザー",
            email: @mail,
            password: @pass,
            password_confirmation: @pass,
            guest: 'true'
          )
      
          if @user.save
            cookies[token_access_key] = cookie_token
            jwt_token = cookies[:access_token]
            response.headers['X-Authentication-Token'] = jwt_token
            render json: @user.my_json
          else
            render json: { status: 500, message: 'ゲスト登録に失敗しました。' }
          end
        end
      
        private
          def random_string(i)
            SecureRandom.alphanumeric(i)
          end
      
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
            @_entity ||= User.find_by(email: @mail)
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
      end
    end
  end  
end