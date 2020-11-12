module UserAuth
  # トークン期限の設定
  mattr_accessor :token_lifetime
  self.token_lifetime = 1.week

  # 受信者を識別する文字列を指定する(誰でも見ることができる)
  # 誰のために発行したかを明確にするためにクライアントドメインを使用
  mattr_accessor :token_audience
  self.token_audience = -> {
    ENV["API_DOMAIN"]
  }

  # 署名アルゴリズムを指定する
  # H256 一つの鍵で署名と検証を行うアルゴリズム
  mattr_accessor :token_signature_algorithm
  self.token_signature_algorithm = "HS256"

  # 署名に使用する鍵を指定
  mattr_accessor :token_secret_signature_key
  self.token_secret_signature_key = -> {
    Rails.application.credentials.secret_key_base
  }

  # 公開鍵を使用する際はここに指定
  mattr_accessor :token_public_key
  self.token_public_key = nil

  # Cookieに保存する際のオブジェクトキーを指定
  # CookieからJWTを取得する場合は、cookies[:access_token]
  mattr_accessor :token_access_key
  self.token_access_key = :access_token

  # ログインユーザーが見つからない場合のRailsの例外を指定
  mattr_accessor :not_found_exception_class
  self.not_found_exception_class = ActiveRecord::RecordNotFound
end