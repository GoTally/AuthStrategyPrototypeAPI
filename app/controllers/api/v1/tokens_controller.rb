class Api::V1::TokensController < ApiController
  def create
    authenticate do |user|
      @token = Token.create
      user.expire_tokens
      user.tokens << @token
      render
    end
  end
end
