require 'rails_helper'

describe 'POST /v1/tokens' do
  it 'creates a token for the user' do

    post '/v1/tokens', {
      uid: '',
      auth_token: '',
      first_name: '',
      last_name: '',
      email: '',
      provider: 'facebook'
    }.to_json,
    request_headers

    token = Token.last
    expect(response_json[:id]).to eq(token.id)
    expect(response_json[:value]).to eq(token.value)
    expect(response_json[:expired_at]).to be_nil
  end
end
