require 'spec_helper'

describe LinksController do
  
  let(:project) { Factory(:project) }

  describe 'creating a link' do
    context 'when not logged in' do
      before { post :create, :project_id => project.id }
      it     { should redirect_to :new_user_session }
    end
    
    context 'when logged in' do
      before { login }

      context 'with invalid data' do
        before  { post :create, :project_id => project.id }
        specify { flash[:alert].should == "Please specify both label and URL for the link." }
        it      { should redirect_to :root }
      end
      
      context 'with valid data' do
        before  { post :create, :project_id => project.id, :link => Factory.attributes_for(:link) }
        specify { flash[:notice].should_not be_nil }
        specify { project.reload.links.should_not be_empty }
        it      { should redirect_to :root }
      end
    end
  end
  
end