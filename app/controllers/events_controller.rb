class EventsController < ApplicationController
  inherit_resources
  defaults :finder => :get

  before_filter :admin_required

  def update
    update! { :root }
  end

  def notify
    Notifier.emit_hacknight_approaching_notification!
    redirect_to :root
  end
end
