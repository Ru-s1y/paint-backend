module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate

      def show
        @album = Album.find_by(user_id: params[:user_id])
        if @album
          render @album and return
        else
          render { message: 'No album' }
        end
      end

      private
    end
  end
end