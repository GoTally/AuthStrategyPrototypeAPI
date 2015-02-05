require 'rails_helper'

describe FacebookAuth do
  describe '::validate' do
    subject{ FacebookAuth.validate(auth_token, '10153057521702250', 'im4ussoccer@yahoo.com') }

    context 'valid token', vcr: { cassette_name: 'facebook_valid_token' } do
      let(:auth_token){'good-token'}

      it { is_expected.to be_truthy }
    end

    context 'invalid token', vcr: { cassette_name: 'facebook_invalid_token' } do
      let(:auth_token){'fail-whale'}

      it { is_expected.to be_falsey }
    end
  end
end
