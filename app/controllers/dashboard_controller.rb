class DashboardController < ApplicationController

  def show
    @projects = Project.all
  end

end
