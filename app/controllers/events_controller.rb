class EventsController < ApplicationController
  inherit_resources

  before_filter :admin_required, :except => [:index, :show]

  def create
    create! { events_path }
  end

  def update
    update! { events_path }
  end
end
