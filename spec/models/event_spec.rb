require 'spec_helper'

describe Event do
  it { should have_fields :when, :address, :phone }
  it { should validate_presence_of :when }
  it { should validate_presence_of :address }
  it { should validate_presence_of :phone }

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


  describe "#upcoming" do
    subject { @event.upcoming? }

    context "it's not yet started" do
      before { @event = Factory :event, :when => Time.now + 1.day }
      it { should be true }
    end

    context "it's left in the past" do
      before { @event = Factory :event, :when => Time.now - 1.day }
      it { should be false }
    end
  end

end
