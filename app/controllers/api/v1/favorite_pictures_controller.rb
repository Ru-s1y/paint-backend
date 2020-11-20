module Api
  module V1
    class FavoritePicturesController < ApplicationController
      before_action :authenticate_user

      def create
        @favopic = Favopic.new(
          user_id: current_user.id,
          picture_id: params[:picture_id]
        )

        if @favopic.save
          render json: @favopic
        else
          render { message: 'error' }
        end
      end

      def destroy
        @favopic = Favopic.find(params[:id])
        @favopic.destroy
        render @favopic
      end
    end
  end
end