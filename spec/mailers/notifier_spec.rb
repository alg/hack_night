require "spec_helper"

describe Notifier do

  before do
    @u = Factory :user
    @hn = Factory :event, :when => Time.now + 1.day, :address => '7Heaven'
  end

  describe "#emit_hacknight_approaching_notification" do
    it "should send direct messages to all users" do
      Notifier.any_instance.stub(:render).and_return("the message")
      Twitterie.should_receive(:post_direct_message).with(@u.nickname, "the message")

      Notifier.emit_hacknight_approaching_notification!
    end
  end

end
