class AttendancesController < ApplicationController
  before_filter :authenticate_user!

  def willgo
    current_user.attend!

    flash[:notice] = "You've reserved a place at the nearest hack night."
    redirect_to :root
  end

  def wontgo
    current_user.skip!

    flash[:notice] = "OK, you're excluded."
    redirect_to :root
  end

end
