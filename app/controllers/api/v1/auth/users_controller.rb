module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate
      before_action :set_user, only: [:edit, :destroy, :edit]

      def show
        @album = Album.find_by(user_id: params[:user_id])
        if @album
          render json: @album and return
        else
          render { message: 'No album' }
        end
      end

      def edit
        if @user.update(user_params)
          render json: @user.my_json
        else
          render json: @user.error
        end
      end

      def destroy
        @user = find(current_user.id)
        if @user.destroy
          render json: @user.my_json
        else
          render { message: 'user_delete_error' }
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
          params.require(:user).permit(:email, :name)
        end
    end
  end
end