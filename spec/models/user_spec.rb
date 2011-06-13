require "spec_helper"

describe User do

  it { should have_fields :name, :location, :nickname, :image, :participating?, :status, :is_admin }

  it { should reference_many :authentications }
  it { should reference_many :messages }
  it { should reference_many :suggested_projects }
  it { should be_referenced_in(:project).as_inverse_of(:members) }
  it { should be_referenced_in(:managed_project).as_inverse_of(:manager) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :nickname }

  describe "involved?" do
    specify { Factory(:user, :project => nil).should_not be_involved }
    specify { Factory(:user, :project => Factory(:project)).should be_involved }
  end

  describe "attend!" do
    before { @user = Factory(:user) }

    specify { @user.should_not be_participating }

    specify "attend! should make the user participating in the next HN" do
      @user.attend!
      @user.should be_participating
    end
  end

  describe "backoff!" do
    before { @user = Factory(:user, :participating? => true) }

    specify { @user.should be_participating }

    specify do
      @user.skip!
      @user.should_not be_participating
    end
  end

  describe "decided?" do
    before { @user = Factory(:user) }

    context "when no decision made" do
      specify { @user.should_not have_decided }
    end

    context "when decided not to go" do
      before { @user.skip! }
      specify { @user.should have_decided }
    end
  end

  describe "scopes" do
    before do
      @wanderer = Factory(:user, :project => nil, :participating? => true)
      @coder    = Factory(:user, :project => Factory(:project), :participating? => true)
      @lazy_gut = Factory(:user, :project => nil, :participating? => false)
    end

    describe "wanderers" do
      subject { User.wanderers }
      it { should include @wanderer }
      it { should_not include @coder, @lazy_gut }
    end

    describe "participants" do
      subject { User.participants }
      it { should include @wanderer, @coder }
      it { should_not include @lazy_gut }
    end
  end


  describe "reset_participants!" do
    before do
      @user = Factory.build(:user)
      User.should_receive(:participants).and_return([@user])
      @user.should_receive(:update_attribute).with(:participating?, nil)
    end

    specify { lambda{ User.reset_participants! }.should_not raise_error }
  end
end
