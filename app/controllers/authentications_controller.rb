class AuthenticationsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    @auth = Authentication.find_from_auth_info(auth) || Authentication.create_from_auth_info!(auth)

    remember(@auth.user)

    flash[:notice] = "Welcome, #{@auth.user.name}."
    sign_in_and_redirect(:user, @auth.user)
  end



  def failure
    flash[:alert] = 'Authentication attempt failed.'
    redirect_to :root
  end


  private

  def remember(user)
    user.remember_me!(Devise.extend_remember_period)

    configuration = {
      :value => User.serialize_into_cookie(user),
      :expires => user.remember_expires_at,
      :path => "/"
    }
    configuration[:domain] = user.cookie_domain if user.cookie_domain?

    cookies.signed["remember_user_token"] = configuration
  end

end
