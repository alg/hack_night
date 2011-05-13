require 'spec_helper'

describe ProjectsController do
  
  before { @user = login }
  
  describe "create" do
    context "valid" do
      before  { post :create, :project => { :name => "sample" } }
      specify { flash[:alert].should be_blank }
      it      { should redirect_to :root }
      specify { assigns(:project).members.should == [ @user ] }
    end

    context "valid project by involved user" do
      let(:current_project) { Factory(:project) }
      before  { @user.update_attributes!(:project => current_project) }
      before  { post :create, :project => { :name => "sample" } }
      specify { assigns(:project).members.should be_empty }
      specify { @user.project.should == current_project }
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