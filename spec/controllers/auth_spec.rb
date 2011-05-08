require 'spec_helper'

describe AuthenticationsController do

  context "on success" do
    before do
      @omniauth = {:provider => 'twitter', :uid => 'someuid12345', 'user_info' => {'name' => 'Billy', 'location' => 'Moon', 'nickname' => 'billibob', 'image' => ''}}
      request.env['omniauth.auth'] = @omniauth
    end

    context "when no user exist" do
      it "should create user and sign him in" do
        post :create

        should redirect_to :root
        flash[:notice].should eql "Welcome, Billy."
      end
    end

    context "when user is already registered" do
      before { Authentication.create_from_auth_info! @omniauth }

      it "should sign him in" do
        User.should_not_receive :create!

        post :create

        should redirect_to :root
        flash[:notice].should eql "Welcome, Billy."
      end
    end

    it "should memorize the user" do
      post :create

      cookies["remember_user_token"].should_not be_nil
    end
  end

  context "on failed attempt" do
    it "should redirect and swear" do
      post :failure

      should redirect_to :root
      flash[:alert].should eql 'Authentication attempt failed.'
    end
  end
end