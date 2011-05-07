class AuthenticationsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    @auth = Authentication.find_from_auth_info(auth) || Authentication.create_from_auth_info(auth)

    flash[:notice] = "Welcome, #{@auth.user.name}."
    sign_in_and_redirect(:user, @auth.user)
  end


  def failure
    flash[:alert] = 'Authentication attempt failed.'
    redirect_to :root
  end

end
