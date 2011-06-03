require 'spec_helper'

describe ScriptsController do

  describe 'GET #show' do

    context 'an existing .coffee' do
      before { CoffeeScript.should_receive(:compile).and_return("the js script") }
      before { get :show, :id => 'dashboard', :format => :js }

      subject { response }

      it { should be_success }
      it { should have_content_type 'text/javascript' }
      specify { subject.headers['Cache-Control'].should match /max-age=\d{2,}/ }
      specify { subject.headers['Last-Modified'].should_not be_blank }

    end


    context 'such .coffee doesn\'t exist' do
      it "should raise 404" do
        get(:show, :id => 'non-existing-script', :format => :js).status.should == 404
      end
    end
  end


  describe "routes" do
    specify do
      { :get => "/javascripts/dashboard.js" }.
        should route_to :controller => 'scripts', :action => 'show', :id => 'dashboard'
    end
  end
end
