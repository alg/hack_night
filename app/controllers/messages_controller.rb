class MessagesController < ApplicationController
  inherit_resources
  before_filter :authenticate_user!

  def create
    @message = Message.new(params[:message])
    @message.author = current_user

    create! do |success, failure|
      failure.html { flash[:alert] = "Be nice, don't post empty threats"; redirect_to :root }
      success.html { redirect_to :root }
    end
  end
end
