class AuthsController < Devise::OmniauthCallbacksController
  
  def facebook
    oauth_auth
  end

  def google_oauth2
    oauth_auth
  end

  private

  def oauth_auth
    user = UserService.new.find_or_create_from_auth(request.env["omniauth.auth"])
    sign_in_and_redirect user
  end
end
