class DashboardController < ApplicationController

  before_filter :authenticate_user!, :show => :update_status

  def show
    @projects          = Project.all
    @upcoming_projects = Project.upcoming
    @board             = Message.for_board
    @wanderers         = User.wanderers
    @event             = Event.get
  end

  def update_status
    current_user.update_attributes!(:status => params[:status])
    redirect_to :root
  end

end
