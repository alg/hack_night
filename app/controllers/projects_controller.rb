class ProjectsController < ApplicationController

  before_filter :authenticate_user!
  
  inherit_resources

  def create
    create! do |success, failure|
      failure.html do
        flash[:alert] = "Please specify the name of the project"
        redirect_to :root
      end

      success.html do
        redirect_to :root
      end
    end
  end

end
