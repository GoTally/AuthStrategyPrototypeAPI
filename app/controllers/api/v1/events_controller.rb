class Api::V1::EventsController < ApiController
  def index
    authorize do |user|
      # We don't really care enough about this logic 
      # for this demonstration
      render json: {message: 'ok'}.to_json
    end
  end
end
