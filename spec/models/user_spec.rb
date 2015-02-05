require 'rails_helper'

describe User, 'Validations' do
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
end

describe User, 'Associations' do
  it { should have_many(:tokens) }
  it { should have_many(:social_identities) }
end
