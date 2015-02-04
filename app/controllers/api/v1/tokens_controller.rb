class Api::V1::TokensController < ApiController
  def create
    @token = Token.new

    if @token.save
      render
    else
      render json: {
        message: 'Authentication Failed',
        errors: @token.errors.full_messages
      }, status: 422
    end
  end
end
