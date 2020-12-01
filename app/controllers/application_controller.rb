class ApplicationController < ActionController::Base
  include ActionController::Cookies
  include UserAuth::Authenticator
  skip_before_action :verify_authenticity_token, railse: false
end
