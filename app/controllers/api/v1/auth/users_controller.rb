module Api
  module V1
    module Auth
      class UsersController < ApplicationController
        before_action :authenticate_user
        before_action :set_user, only: [:config_user, :destroy, :update]
  
        def config_user
          render json: @user.config_json
        end
  
        def update
          if @user&.authenticate(user_params[:password])
            @user.update(user_params)
            render json: @user.my_json
          else
            render json: { message: 'update_faild' }
          end
        end
  
        def destroy
          @user = find(current_user.id)
          if @user.destroy
            render json: @user.my_json
          else
            render json: { message: 'user_delete_error' }
          end
        end
  
        private
          def set_user
            @user = User.find(current_user.id)
          end
  
          def user_secure_params
            params.require(:user).permit(:email, :password, :password_confirmation)
          end
  
          def user_params
            params.require(:user).permit(:name, :password)
          end
      end
    end
  end
end