module UserAuth

  # トークンの発行と発行主の検索を行う
  module Tokenizable

    def self.included(base)
      base.extend ClassMethods
    end

    ## class method
    module ClassMethods

      # トークンをデコードしたpayloadのユーザーID（sub）からユーザーを検索し返す
      def from_token(token)
        auth_token = AuthToken.new(token: token)
        from_token_payload(auth_token.payload)
      end

      private
        def from_token_payload(payload)
          find(payload["sub"])
        end
    end

    ## instance method
    # トークンを返す
    def to_token
      AuthToken.new(payload: to_token_payload).token
    end

    # 有効期限付きのトークンを返す
    def to_lifetime_token(lifetime)
      auth = AuthToken.new(lifetime: lifetime, payload: to_token_payload)
      { token: auth.token }
      # { token: auth.token, lifetime_text: auth.lifetime_text }
    end

    # なんか使えない
    # token_lifetimeの日本語変換を返す
    def lifetime_text
      time, period = @lifetime.inspect.sub(/s\z/,"").split
      time + I18n.t("datetime.periods.#{period}", default: "")
    end

    private
      def to_token_payload
        { sub: id }
      end
  end
end