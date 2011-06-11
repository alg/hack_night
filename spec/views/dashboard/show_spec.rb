require 'spec_helper'

describe "dashboard/show.haml" do

  before do
    assign :board, []
    assign :projects, []
    assign :wanderers, []

    controller.singleton_class.class_eval do
      def user_signed_in?
        false
      end
      helper_method :user_signed_in?
    end
  end


  specify "should render somehow" do
    lambda{ render }.should_not raise_error
  end

end
