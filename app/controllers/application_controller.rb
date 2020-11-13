class ApplicationController < ActionController::Base
  include ActionController::Cookies
  include UserAuth::Authenticator
  skip_before_action :verify_authenticity_token, railse: false

  # 全部にcookieとtokenが一致してるか確認
  # def 
  #   jwt_token = cookies[:access_token]
  # end
end
