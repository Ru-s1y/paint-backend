module Api
  module V1
    class FavoritePicturesController < ApplicationController
      before_action :authenticate_user
      before_action :set_favopic, only: [:favo_confirm, :destroy]

      def index
        @favopics = Favopic.where(user_id: current_user.id)
        render 'index.json.jbuilder'
      end

      def favo_confirm
        if @favopic.present?
          @count = Favopic.where(picture_id: params[:picture_id]).count
          render 'favo_confirm.json.jbuilder'
        else
          render json: { favorite: false }
        end
      end

      def create
        @favopic = Favopic.new(
          user_id: current_user.id,
          picture_id: params[:picture_id]
        )

        if @favopic.save
          render json: @favopic
        else
          render json: { message: 'error' }
        end
      end

      def destroy
        @favopic.destroy
        render json: @favopic
      end

      private
        def set_favopic
          @favopic = Favopic.find_by(picture_id: params[:picture_id], user_id: current_user.id)
        end
    end
  end
end