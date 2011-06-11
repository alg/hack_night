require 'spec_helper'

describe DashboardController do
  before { @user = login }

  describe "#show" do
    before { get :show }
    it     { should assign_to :projects }
    it     { should assign_to :wanderers }
    it     { should assign_to :upcoming_projects}
    it     { should assign_to :event }
  end

  describe "message board" do
    before { Message.should_receive(:for_board).and_return([]) }
    before { get :show }
    it     { should assign_to :board }
  end

  describe "update status" do
    context "as logged in" do
      before  { post :update_status, :status => "new status" }
      before  { @user.reload }
      specify { @user.status.should == "new status" }
      it      { should redirect_to :root }
    end

    context "as logged out" do
      before  { logout }
      before  { post :update_status }
      it      { should redirect_to :new_user_session }
    end
  end

end
