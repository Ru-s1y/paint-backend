module Api
  module V1
    class FavoriteAlbumsController < ApplicationController
      include Pagination
      before_action :authenticate_user
      before_action :set_favoalb, only: [:favo_confirm, :destroy]

      def index
        @favoalbs = Favoalb.where(user_id: current_user.id).page(params[:page]).per(6)
        pagenation = resources_with_pagination(@favoalbs)
        render 'index.json.jbuilder'
      end

      def favo_confirm
        if @favoalb.present?
          @count = Favoalb.where(album_id: params[:album_id]).count
          render 'favo_confirm.json.jbuilder'
        else
          render json: { favorite: false }
        end
      end

      def create
        @favoalb = Favoalb.new(
          user_id: current_user.id,
          album_id: params[:album_id]
        )

        if @favoalb.save
          render json: @favoalb
        else
          render json: { message: 'error' }
        end
      end

      def destroy
        @favoalb.destroy
        render json: @favoalb
      end

      private
        def set_favoalb
          @favoalb = Favoalb.find_by(album_id: params[:album_id], user_id: current_user.id)
        end
    end
  end
end