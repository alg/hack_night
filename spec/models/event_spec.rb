require 'spec_helper'

describe Event do
  it { should have_fields :when, :info }
  it { should validate_presence_of :when }
  it { should validate_presence_of :info }

  describe "self.get" do
    subject { Event.get }

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
