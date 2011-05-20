require 'spec_helper'

describe ProjectsController do
  
  let(:project) { Factory(:project) }

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
  
  describe "join" do
    context "when not logged in" do
      before  { logout }
      before  { get :join, :id => 1 }
      it      { should redirect_to :new_user_session }
    end
    
    context "first project" do
      before  { get :join, :id => project.id }
      before  { @user.reload }
      specify { @user.project.should == project }
      it      { should redirect_to :root }
    end
    
    context "when already in some project" do
      let(:current_project) { Factory(:project) }
      before  { @user.project = current_project; @user.save }
      before  { get :join, :id => project.id }
      before  { @user.reload }
      specify { @user.project.should == current_project }
      specify { flash[:alert].should == "You are currently involved in #{current_project.name}. You need to leave it first." }
      it      { should redirect_to :root }
    end
    
    context "unknown project" do
      before  { get :join, :id => -1 }
      specify { flash[:alert].should == "The project you wished to join is missing." }
      it      { should redirect_to :root }
    end    
    
    context "no vacant slots" do
      before  { project.update_attributes!(:slots => 0) }
      before  { get :join, :id => project.id }
      specify { flash[:alert].should == "This project doesn't have vacant slots. Talk to the members." }
      it      { should redirect_to :root }
    end
    
    context "as a first member of the project" do
      before  { get :join, :id => project.id }
      specify { @user.reload.should be_manager_of project }
    end
    
    context "as a second member of the project" do
      before  { project.members << Factory(:user) }
      before  { get :join, :id => project.id }
      specify { @user.reload.should_not be_manager_of project }
    end
  end
  
  describe "leave" do
    let(:current_project) { Factory(:project) }
    before  { @user.project = current_project; @user.save }

    context "when not logged in" do
      before  { logout }
      before  { get :leave, :id => 1 }
      it      { should redirect_to :new_user_session }
    end
    
    context "project the user is a part of" do
      before  { get :leave, :id => current_project.id.to_s }
      before  { @user.reload }
      specify { @user.should_not be_involved }
      it      { should redirect_to :root }
    end
    
    context "project the user is not a part of" do
      before  { get :leave, :id => project.id }
      before  { @user.reload }
      specify { @user.project.should == current_project }
      specify { flash[:alert].should == "You are not a part of this project." }
      it      { should redirect_to :root }
    end
    
    context "as a manager with some members left" do
      before  { current_project.members << Factory(:user) }
      before  { @user.managed_project = current_project; @user.save }
      before  { get :leave, :id => current_project.id.to_s }
      specify { flash[:alert].should == "You are the manager of this project. Relay your role to someone before leaving." }
      it      { should redirect_to :root }
    end
    
    context "as a manager and the last member" do
      before  { @user.managed_project = current_project; @user.save }
      before  { get :leave, :id => current_project.id.to_s }
      specify { @user.reload.should_not be_manager_of current_project }
      it      { should redirect_to :root }
    end
  end
  
end