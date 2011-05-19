class DashboardController < ApplicationController

  def show
    @projects = Project.all
    @upcoming_projects = Project.upcoming
    @board = Message.for_board
    @wanderers = User.wanderers
  end

end
