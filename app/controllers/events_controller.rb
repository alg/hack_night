class EventsController < ApplicationController
  inherit_resources
  defaults :finder => :get

  before_filter :admin_required

  def update
    update! { :root }
  end
end
