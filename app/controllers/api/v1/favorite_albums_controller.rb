module Api
  module V1
    class FavoriteAlbumsController < ApplicationController
      before_action :authenticate_user

      def create
        @favoalb = Favoalb.new(
          user_id: current_user.id,
          album_id: params[:album_id]
        )

        if @favoalb.save
          render json: @favoalb
        else
          render { message: 'error' }
        end
      end

      def destroy
        @favoalb = Favoalb.find(params[:id])
        @favoalb.destroy
        render @favoalb
      end
    end
  end
end