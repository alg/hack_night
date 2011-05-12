class DashboardController < ApplicationController

  def show
    @projects = Project.all
    @board = Message.for_board
  end

end
