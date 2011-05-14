class DashboardController < ApplicationController

  def show
    @projects = Project.all
    @board = Message.for_board
    @wanderers = User.wanderers
  end

end
