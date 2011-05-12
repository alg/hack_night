require 'spec_helper'

describe Message do
  it { should have_fields :body, :created_at }
  it { should validate_presence_of :body }

  it { should belong_to :author }
  it { should validate_presence_of :author_id }


  describe "#for_board" do
    it "should show all messages ordered by date (will do for now)" do
      Message.should_receive(:asc).with(:created_at)
      Message.for_board
    end
  end
end
