require 'spec_helper'

describe DashboardController do
  before { sign_in :user, Factory.create(:user) }

  describe "#show" do
    before { get :show }
    it     { should assign_to :projects }
  end


  describe "message board" do
    it "#show should load messages" do
      Message.should_receive(:for_board).and_return([])

      get :show

      should assign_to :board
    end
  end
end
