require 'spec_helper'

describe ProjectsController do
  
  before { login }
  
  describe "create" do
    context "valid" do
      before  { post :create, :project => { :name => "sample" } }
      it      { should redirect_to :root }
    end
    
    context "invalid" do
      before  { post :create }
      specify { flash[:alert].should_not be_empty }
      it      { should redirect_to :root }
    end
    
    context "when not logged in" do
      before  { logout }
      before  { post :create, :project => Factory.attributes_for(:project) }
      it      { should redirect_to :new_user_session }
    end
  end
  
end