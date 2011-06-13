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

    context "it's not setup at all" do
      before { @event = Event.new }
      it { should be false }
    end

    context "it's not yet started" do
      before { @event = Factory :event, :when => Time.now + 1.day }
      it { should be true }
    end

    context "it's left in the past" do
      before { @event = Factory :event, :when => Time.now - 1.day }
      it { should be false }
    end
  end


  describe "#is_a_new_event?" do
    subject { @event.is_a_new_event? }

    context "no event exist" do
      before { @event = Event.new }
      it { should be_false }
    end

    context "a past event exist" do
      before { @event = Factory(:event, :when => 1.month.ago) }
      it { should be_false}

      context "when I create a new event" do
        before { @event.when = 1.week.since }
        it { should be_true}
      end
    end

    context "upcoming event exist" do
      before { @event = Factory(:event, :when => 1.month.since) }
      before { @event.when = 2.month.since }
      it { should be_false }
    end
  end


  describe "reset_participants!" do
    context "it's a new event" do
      before { Event.any_instance.stub(:is_a_new_event?).and_return(true) }
      before { User.should_receive(:reset_participants!) }

      specify { lambda{ Event.get.reset_participants! }.should_not raise_error }
    end

    context "it's not a new event" do
      before { Event.any_instance.stub(:is_a_new_event?).and_return(false) }
      before { User.should_not_receive(:reset_participants!) }

      specify { lambda{ Event.get.reset_participants! }.should_not raise_error }
    end

    describe "should be called on save" do
      before { Event.any_instance.should_receive(:reset_participants!) }
      specify { Factory.build(:event).save! }
    end
  end

end
