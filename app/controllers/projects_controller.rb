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

  def join
    @project = Project.find(params[:id])

    if current_user.involved?
      flash[:alert] = "You are currently involved in #{current_user.project.name}. You need to leave it first."
    else
      current_user.project = @project
      current_user.save
    end
  rescue Mongoid::Errors::DocumentNotFound
    flash[:alert] = "The project you wished to join is missing."
  ensure
    redirect_to :root
  end
  
  def leave
    if current_user.project_id.to_s == params[:id]
      current_user.update_attributes!(:project_id => nil)
    else
      flash[:alert] = "You are not a part of this project."
    end

    redirect_to :root
  end
  
end
