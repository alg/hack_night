require 'spec_helper'

describe DashboardController do
  describe "GET on #show" do
    before { get :show }
    it { should assign_to :projects }
  end
end
