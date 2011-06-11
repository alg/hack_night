require 'spec_helper'

describe Event do
  it { should have_fields :when, :info }
  it { should validate_presence_of :when }
  it { should validate_presence_of :info }

  describe "self.get" do
    subject { Event.get }

    it "should accept and ignore ID argument" do
      lambda{ Event.get(123) }.should_not raise_error
    end

    context "no record exist" do
      it { should be_a Event }
      it { should be_new_record }
    end

    context "already exists" do
      before { @ev = Factory :event }
      it { should eql @ev }
    end
  end
end
