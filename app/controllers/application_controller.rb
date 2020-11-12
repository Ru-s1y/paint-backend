class ApplicationController < ActionController::Base
  # include JwtAuthenticator

  skip_before_action :verify_authenticity_token, railse: false
  # helper_method :current_user

end
