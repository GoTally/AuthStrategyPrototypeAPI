require 'rails_helper'

describe SocialIdentity, 'Associations' do
  it { should belong_to(:user) }
end
