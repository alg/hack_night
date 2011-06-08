require 'spec_helper'
require 'twitterie'

def tw_response(name)
  File.open("spec/fixtures/twitter-responses/#{name}.response")
end

def tw_stub_request(method, api_call, *args)
  stub_request(method, "http://api.twitter.com/1/#{api_call}.json", *args)
end


describe Twitterie do
  after { WebMock.disable_net_connect!(:allow_localhost => true) }


  describe 'timeline' do
    before { tw_stub_request(:get, "statuses/home_timeline").to_return(:body => tw_response("statuses-home_timeline.success")) }
    specify { Twitterie.timeline.should be_a Array }
  end


  describe 'send a message' do
    context 'recipient is valid' do
      before { tw_stub_request(:post, "direct_messages/new").to_return(:body => tw_response("direct_messages-new.success")) }
      specify { lambda { Twitterie.post_direct_message("micky_mouse", "hi there") }.should_not raise_error }
    end

    context 'recipient is invalid' do
      before { tw_stub_request(:post, "direct_messages/new").to_return(:status => 403, :body => tw_response("direct_messages-new.forbidden")) }
      specify { lambda { Twitterie.post_direct_message("tom_the_cat", "hi there") }.should raise_error(Twitterie::ApiError) }
    end
  end


  describe "send a tweet" do
    before { tw_stub_request(:post, "statuses/update").to_return(:body => tw_response("statuses-update.success")) }
    specify { lambda { Twitterie.update_status("playing nice with the kitten #{Time.now}") }.should_not raise_error }
  end


  describe "remove all the tweets" do
    specify "should remove every tweet from the timeline" do
      tw_stub_request(:get, "statuses/home_timeline").to_return(:body => tw_response("statuses-home_timeline.success"))
      stub_request(:post, /http:\/\/api.twitter.com\/1\/statuses\/destroy\/.*/).to_return(:body => tw_response("statuses-destroy.success"))
      @tweets = Twitterie.timeline

      @tweets.each do |tweet|
        lambda{ Twitterie.destroy(tweet["id"]) }.should_not raise_error
      end
    end
  end
end
