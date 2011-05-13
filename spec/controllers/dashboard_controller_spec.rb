require 'spec_helper'

describe DashboardController do
  before { login }

  describe "#show" do
    before { get :show }
    it     { should assign_to :projects }
  end

  describe "message board" do
    before { Message.should_receive(:for_board).and_return([]) }
    before { get :show }
    it     { should assign_to :board }
  end
end
