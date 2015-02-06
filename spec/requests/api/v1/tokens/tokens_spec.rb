require 'rails_helper'

describe 'POST /v1/tokens' do
  it 'creates a token for the user', vcr: { cassette_name: 'facebook_valid_token' } do

    post '/v1/tokens', {
      uid: '10153057521702250',
      auth_token: 'good-token',
      first_name: 'Jeff',
      last_name: 'Fisher',
      email: 'im4ussoccer@yahoo.com',
      provider: 'facebook'
    }.to_json,
    request_headers

    token = Token.last
    expect(response_json[:id]).to eq(token.id)
    expect(response_json[:value]).to eq(token.value)
    expect(response_json[:expired_at]).to be_nil
  end

  it 'does not create a token' do

    post '/v1/tokens', {}, request_headers

    expect(response).to have_http_status(401)
  end
end
