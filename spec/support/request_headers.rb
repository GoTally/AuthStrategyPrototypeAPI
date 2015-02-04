module RequestHeaders
  def request_headers(api_token='requesting')
    {
      'api-token' => api_token,
      'Content-Type' => 'application/json'
    }
  end
end

RSpec.configure do |config|
  config.include RequestHeaders
end
