require 'rails_helper'

describe 'GET /v1/events' do
  let(:user){ create(:user_with_tokens) }

  it 'returns events' do

    get '/v1/events', {}, request_headers(user.tokens.last.value)

    expect(response).to have_http_status(200)
    expect(response_json[:message]).to eq('ok')
  end

  it 'returns 401' do
    get '/v1/events', {}, request_headers('fail-whale')

    expect(response).to have_http_status(401)
  end
end
