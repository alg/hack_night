require 'spec_helper'

describe "coffee scripts" do

  describe 'GET a script' do

    context 'an existing .coffee' do
      before { get "/javascripts/dashboard.js", :format => :js }

      subject { response }

      it { should be_success }
      # specify { subject.headers['Cache-Control'].should match /max-age=\d{2,}/ }
      specify { subject.headers['Last-Modified'].should_not be_blank }

    end


    context 'such .coffee doesn\'t exist' do
      it "should raise 404" do
        lambda { get("/javascripts/non-existing-script.js", :format => :js) }.
          should raise_error(ActionController::RoutingError)
      end
    end
  end
end
