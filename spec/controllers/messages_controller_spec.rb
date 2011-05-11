require 'spec_helper'

describe MessagesController do
  describe "create a message" do
    before { sign_in :user, Factory.create(:user) }

    context "if valid data provided" do
      before { post :create, :message => Factory.build(:message).attributes }

      it { should redirect_to :root }
      specify { assigns[:message].should_not be_new_record }
    end

    context "if data is invalid" do
      before { post :create, :message => {} }
      it { should redirect_to :root }
      specify { flash[:alert].should_not be_empty }
    end

    context "if user not logged in" do
      before {
        sign_out :user
        post :create, :message => Factory.build(:message).attributes
      }

      specify { assigns[:message].should_not be_valid }
    end
  end
end
