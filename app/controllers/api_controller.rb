class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def authenticate
    # check provider
    # verify authentication with provider
    # look up or create user
    # yield user
    # if authentication fails return 401

    if authentication_valid?
      yield current_user
    else
      render nothing: true, status: 401
    end
  end

  def authorize
    if active_api_token?
      user = User.find_by_active_token_hash(api_token)
      yield user
    else
      render nothing: true, status: 401
    end
  end

private

  def authentication_valid?
    case params['provider']
    when 'facebook'
      FacebookAuth.validate(params['auth_token'], params['uid'], params['email'])
    else
      false
    end
  end

  def current_user
    user_from_email || create_user_from_social_identity
  end

  def user_from_email
    User.find_by_email(params['email'])
  end

  def create_user_from_social_identity
    User.create_from_social_identity(provider_params)
  end

  def provider_params
    params.permit(:provider, :email, :username, :uid, :first_name, :last_name, :auth_token)
  end

  def active_api_token?
    Token.hash_active?(api_token)
  end

  def api_token
    request.headers['api-token']
  end
end
