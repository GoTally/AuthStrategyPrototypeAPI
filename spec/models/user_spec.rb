require 'rails_helper'

describe User do
  describe '.create_from_provider' do
    subject(:user){ User.create_from_social_identity(social_identity_params) }
    let(:social_identity_params){
      {
        uid: '10153057521702250',
        auth_token: 'good-token',
        first_name: 'Jeff',
        last_name: 'Fisher',
        email: 'im4ussoccer@yahoo.com',
        provider: 'facebook'
      }
    }

    it 'should create a user and social identity' do
      expect(user.first_name).to eq('Jeff')
      expect(user.last_name).to eq('Fisher')
      expect(user.email).to eq('im4ussoccer@yahoo.com')
      expect(user.social_identities.count).to eq(1)
      expect(user.social_identities.first.uid).to eq('10153057521702250')
    end
  end

  describe '.find_by_active_token_hash' do
    let(:user){ create(:user_with_token) }
    let(:token){ user.tokens.first }

    it 'returns the user from the active token hash' do
      expect(User.find_by_active_token_hash(token.value)).to eq(user)
    end
  end

  describe '#expire_tokens' do
    subject(:user){
      create(:user) do |u|
        u.tokens << create_list(:token, 3)
      end
    }

    it 'should expire tokens only associated with user' do
      unexpired_token = create(:token)
      user.expire_tokens

      expect(user.tokens.all?{|t| t.expired?}).to be_truthy
      expect(Token.active.count).to eq(1)
      expect(unexpired_token.expired?).to be_falsey
    end
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'associations' do
    it { should have_many(:tokens) }
    it { should have_many(:social_identities) }
  end
end
