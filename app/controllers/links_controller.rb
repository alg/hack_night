class LinksController < ApplicationController
  
  before_filter :authenticate_user!
  
  inherit_resources
  belongs_to :project
  
  def create
    link = Link.new(params[:link])

    if link.valid?
      parent.links << link
      flash[:notice] = "Added link to your project."
    else
      flash[:alert] = "Please specify both label and URL for the link."
    end
    
    redirect_to :root
  end

end