require 'rails_helper'

describe Token do
  describe '.active' do
    it 'returns tokens that are not expired' do
      t1 = Token.create!
      t2 = Token.create!(expired_at: Time.now)
      t3 = Token.create!

      expect(Token.active).to_not be_empty
      expect(Token.active.count).to eq(2)
      expect(Token.active).to_not include(t2)
      expect(Token.active).to include(t1, t3)
    end
  end

  describe '.hash_active?' do
    subject(:hash){ create(:token).value }

    it 'return if the hash value is of an active token' do
      expect(Token.hash_active?(hash)).to be_truthy
    end
  end

  describe '#expire' do
    subject(:token){ Token.create!}

    it 'should have an expiration date' do
      expect(token.expire.to_i).to eq(Time.zone.now.to_i)
      expect(token.expired_at).to_not be_nil
    end
  end

  describe '#expired?' do
    subject(:token){ create(:token) }

    it 'should return state of token' do
      expect(token.expired?).to be_falsey
      token.expire
      expect(token.expired?).to be_truthy
    end
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:value) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
