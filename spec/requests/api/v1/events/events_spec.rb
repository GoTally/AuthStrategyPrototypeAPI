require 'rails_helper'

describe 'GET /v1/events' do
  let(:user){ create(:user_with_token) }

  it 'returns events' do

    get '/v1/events', {}, request_headers(user.tokens.first.value)

    expect(response).to have_http_status(200)
    expect(response_json[:message]).to eq('ok')
  end
end