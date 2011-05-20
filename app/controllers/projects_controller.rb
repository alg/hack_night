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
    elsif !@project.has_vacant_slots?
      flash[:alert] = "This project doesn't have vacant slots. Talk to the members."
    else
      current_user.managed_project = @project unless @project.members.any?
      current_user.project = @project
      current_user.save
    end
  rescue Mongoid::Errors::DocumentNotFound
    flash[:alert] = "The project you wished to join is missing."
  ensure
    redirect_to :root
  end
  
  def leave
    project = Project.find(params[:id])
    
    if current_user.project == project
      if current_user.manager_of?(project) && project.members.count > 1
        flash[:alert] = "You are the manager of this project. Relay your role to someone before leaving."
      else
        current_user.project = nil
        current_user.managed_project = nil
        current_user.save
      end
    else
      flash[:alert] = "You are not a part of this project."
    end

    redirect_to :root
  end
  
end
