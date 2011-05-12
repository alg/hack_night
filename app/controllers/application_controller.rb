class ApplicationController < ActionController::Base
  include InheritedResources::DSL

  protect_from_forgery
  before_filter :try_to_recall_user, :unless => :user_signed_in?

  def try_to_recall_user
    if c = cookies.signed['remember_user_token'] and u = User.serialize_from_cookie(c[0], c[1])
      sign_in :user, u
    end
  end
end
