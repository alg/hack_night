require 'spec_helper'

describe AttendancesController do
  before { login }

  context "User wants to participate" do
    before { subject.current_user.should_receive(:attend!) }
    before { post :willgo }

    it { should redirect_to :dashboard }
    specify { flash[:notice].should_not be_empty }
  end

  context "User has other things to do" do
    before { subject.current_user.should_receive(:skip!) }
    before { post :wontgo }

    it { should redirect_to :dashboard }
    specify { flash[:notice].should_not be_empty }
  end
end
