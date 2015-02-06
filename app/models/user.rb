class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :tokens
  has_many :social_identities

  def self.create_from_social_identity(social_identity_params)
    user_params = social_identity_params.slice(:first_name, :last_name, :email)
    User.new(user_params).tap do |user|
      s = SocialIdentity.create(social_identity_params)
      user.social_identities << s
      user.save!
    end
  end
end
