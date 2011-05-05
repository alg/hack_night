class AuthenticationsController < ApplicationController

  def create
    new_user  = false
    auth      = request.env['omniauth.auth']
    @auth     = Authentication.find_from_auth_info(auth)

    unless @auth
      new_user = true
      @auth = Authentication.create_from_auth_info(auth, current_user)
    end
    
    self.current_user = @auth.user
    
    redirect_to new_user ? new_survey_url : surveys_url
  end

end
