require 'spec_helper'

describe Message do
  it { should have_fields :body, :created_at }
  it { should validate_presence_of :body }

  it { should belong_to :author }
  it { should validate_presence_of :author_id }


  describe "#for_board" do
    it "should show last 5 messages" do
      # anybody knowing how to spec it w/o ugly
      # should_receive().and_return ?
      pending
    end
  end
end
