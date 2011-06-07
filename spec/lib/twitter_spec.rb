require 'spec_helper'
require 'twitterie'

class Twit
  include Twitterie
end

describe "Twitter" do
  specify "get timeline" do
    # WebMock.allow_net_connect!
    stub_request(:get, "http://api.twitter.com/1/statuses/home_timeline.json").to_return(:body => 'blaa')

    response = Twit.new.timeline
    # data = ActiveSupport::JSON.decode(response.body)

    response.code.should eql "200"
    response.body.should_not be_empty
  end

  specify "send a message" do
    WebMock.allow_net_connect!

    # stub_request(:post, "http://api.twitter.com/version/direct_messages/new.json")

    response = Twit.new.post_direct_message("iosadchii", "hi there")
    response.code.should eql "200"
    response.body.should include "hi there"
  end


  describe "send a twit" do
    before :all do
      WebMock.allow_net_connect!

      @response = Twit.new.update_status("playing nice with the kitten #{Time.now}")
    end

    specify { @response.code.should eql "200" }
    specify { @response.body.should include "playing nice with the kitten"}
  end


  describe "remove all the twits" do
    before { @twits = Twit.new.timeline }

    specify "should remove every twit from the timeline" do
      WebMock.allow_net_connect!

      @twits.each do |twit|
        response = Twit.new.destroy(twit["id"])
        response.code.should eql "200"
      end
    end
  end
end
