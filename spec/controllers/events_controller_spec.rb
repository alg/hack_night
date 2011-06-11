require 'spec_helper'

describe EventsController do

  before { login(user) }
  let(:event) { Factory :event }

  context 'when current user is admin' do
    let(:user) { Factory :user, :is_admin => true }

    describe "update" do
      context "valid" do
        before  { put :update, :event => Factory.attributes_for(:event) }
        specify { flash[:alert].should be_blank }
        it      { should redirect_to :root }
      end


      context "invalid" do
        before  { put :update, :event => {} }
        it      { should render_template :edit }
      end
    end
  end


  context "when current user isn't admin" do
    let(:user) { Factory :user, :is_admin => false }

    describe "edit" do
      before { get :edit, :id => event.id }
      it_behaves_like "admin area"
    end

    describe "update" do
      before  { put :update, :id => event.id }
      it_behaves_like "admin area"
    end
  end
end
