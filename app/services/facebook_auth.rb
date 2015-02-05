class FacebookAuth
  def self.validate(auth_token, uid, email)
    @auth_token = auth_token
    @uid = uid
    @email = email

    begin
      profile = graph_api.get_object('me')
    rescue
      return false
    end

    profile['id'] == @uid && profile['email'] == @email
  end

private

  def self.graph_api
    Koala::Facebook::API.new(@auth_token)
  end
end
