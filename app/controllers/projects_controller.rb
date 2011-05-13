class ProjectsController < ApplicationController

  before_filter :authenticate_user!
  
  inherit_resources

  def create
    @project = Project.new(params[:project])
    @project.originator = current_user

    if @project.save
      @project.members << current_user unless current_user.involved?
    else
      flash[:alert] = "Please specify the name of the project"
    end
    
    redirect_to :root
  end

end
