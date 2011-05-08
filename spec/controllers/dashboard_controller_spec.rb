require 'spec_helper'

describe DashboardController do
  before { sign_in :user, Factory.create(:user) }

  describe "GET on #show" do
    before { get :show }
    it { should assign_to :projects }
  end
end
