require 'spec_helper'

describe EventsController do

  before { login(user) }
  let(:event) { Factory :event }

  context 'when current user is admin' do
    let(:user) { Factory :user, :is_admin => true }

    describe "index" do
      before { get :index }
      it { should respond_with :success } 
      it { should assign_to :events }
    end

    describe "show" do
      before { get :show, :id => event.id }
      it { should respond_with :success } 
      it { should assign_to :event }
    end

    describe "create" do
      context "valid" do
        before  { post :create, :event => Factory.attributes_for(:event) }
        specify { flash[:alert].should be_blank }
        it      { should redirect_to :events }
      end


      context "invalid" do
        before  { post :create }
        it      { should render_template :new }
      end
    end

    describe "update" do
      context "valid" do
        before  { put :update, :id => event.id, :event => Factory.attributes_for(:event) }
        specify { flash[:alert].should be_blank }
        it      { should redirect_to :events }
      end


      context "invalid" do
        before  { put :update, :id => event.id, :event => {} }
        it      { pending }
      end
    end
  end


  context "when current user isn't admin" do
    let(:user) { Factory :user, :is_admin => false }

    describe "index" do
      before { get :index }
      it { should respond_with :success } 
      it { should assign_to :events }
    end

    describe "show" do
      before { get :show, :id => event.id }
      it { should respond_with :success } 
      it { should assign_to :event }
    end

    describe "new" do
      before { get :new }
      it_behaves_like "admin area"
    end

    describe "edit" do
      before { get :edit, :id => event.id }
      it_behaves_like "admin area"
    end

    describe "create" do
      before  { post :create, :event => Factory.attributes_for(:event) }
      it_behaves_like "admin area"
    end

    describe "update" do
      before  { put :update, :id => event.id }
      it_behaves_like "admin area"
    end

    describe "destroy" do
      before  { post :destroy, :id => event.id }
      it_behaves_like "admin area"
    end
  end
end
