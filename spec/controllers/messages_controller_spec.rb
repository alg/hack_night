require 'spec_helper'

describe MessagesController do
  describe "create a message" do
    before { login }

    context "if valid data provided" do
      before  { post :create, :message => Factory.attributes_for(:message) }
      it      { should redirect_to :root }
      specify { assigns[:message].should_not be_new_record }
    end

    context "if data is invalid" do
      before  { post :create }
      it      { should redirect_to :root }
      specify { flash[:alert].should_not be_empty }
    end

    context "if user not logged in" do
      before  { logout }
      before  { post :create, :message => Factory.attributes_for(:message) }
      specify { assigns[:message].should_not be_valid }
    end
  end
end
