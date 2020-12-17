module Api
  module V1
    class PicturesController < ApplicationController
      include Pagination
      before_action :set_picture, only: [:show, :destroy, :update]
      before_action :authenticate_user
    
      # 公開ピクチャー一覧
      def index
        @pictures = Picture.where(publish: true).order(created_at: :DESC).page(params[:page]).per(6)
        pagenation = resources_with_pagination(@pictures)
        render 'paginate.json.jbuilder'
      end
    
      # マイピクチャー一覧
      def myindex
        @pictures = Picture.where(user_id: current_user.id).order(created_at: :DESC).page(params[:page]).per(6)
        pagenation = resources_with_pagination(@pictures)
        render 'paginate.json.jbuilder'
      end
    
      # アルバムのピクチャー一覧
      def album_index
        @pictures = Picture.where(album_id: params[:album_id], publish: true).order(pagenumber: :ASC)
        # render json: @pictures
        render 'index.json.jbuilder'
      end
    
      # マイアルバムのピクチャー一覧
      def album_myindex
        @pictures = Picture.where(album_id: params[:album_id]).order(pagenumber: :ASC)
        # render json: @pictures
        render 'index.json.jbuilder'
      end

      # ピクチャー検索用
      def search_pictures
        @pictures = Picture.search(params[:search]).limit(20)
        if @pictures
          render 'index.json.jbuilder'
        else
          render json: { message: 'not found' }
        end
      end

      # マイピクチャー検索用
      def search_mypictures
        @pictures = Picture.mysearch(params[:search], current_user).limit(20)
        if @pictures
          render 'index.json.jbuilder'
        else
          render json: { message: 'not found' }
        end
      end
    
      # ピクチャー作成
      def create
        image = params['picture']['image']
        uri = URI.parse(image)
        
        if uri.scheme == "data" then
          data = decode(uri)
          extension = extension(uri)
          imageURL = put_s3 data, extension
        end
    
        if imageURL
          @picture = Picture.create!(
            title: params['picture']['title'],
            description: params['picture']['description'],
            album_id: params['picture']['album_id'],
            user_id: current_user.id,
            publish: params['picture']['publish'],
            pagenumber: params['picture']['pagenumber'],
            image_path: imageURL
          )
          render json: @picture
        else
          render json: @picture.error
        end
      end
    
      # ピクチャー削除
      def destroy
        @picture.destroy
        render json: @picture
      end
    
      # ピクチャー編集
      def update
        if @picture.update(picture_update_params)
          render json: @picture
        else
          render json: @picture.error
        end
      end
    
      private
        def set_picture
          @picture = Picture.find(params[:id])
        end
    
        def picture_params
          params.require(:picture).permit(:title, :description, :album_id, :publish, :pagenumber, :image, :image_path)
        end
    
        def picture_update_params
          params.require(:picture).permit(:title, :description, :album_id, :publish, :pagenumber)
        end
    
        def decode(uri)
          opaque = uri.opaque
          data = opaque[opaque.index(",") + 1, opaque.size]
          Base64.decode64(data)
        end
    
        # 拡張子の取得
        def extension(uri)
          opaque = uri.opaque
          mime_type = opaque[0, opaque.index(";")]
          case mime_type
          when "image/png" then
            ".png"
          when "image/jpeg" then
            ".jpg"
          else
            raise "Unsupport Content-Type"
          end
        end
    
        def put_s3(data, extension)
          file_name = Digest::SHA1.hexdigest(data) + extension
          s3 = Aws::S3::Resource.new(
            :region => ENV['AWS_S3_REGION'],
            :access_key_id => ENV['AWS_IAM_ACCESS_KEY_ID'],
            :secret_access_key => ENV['AWS_IAM_ACCESS_KEY']
          )
          bucket = s3.bucket("ru-s1y-pic-sv")
          obj = bucket.object("uploader/#{current_user.id}/#{current_user.name}/#{file_name}")
          obj.put(acl: "public-read", body: data)
          obj.public_url
        end
    end
  end
end
