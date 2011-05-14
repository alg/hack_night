require "spec_helper"

describe User do

  it { should have_fields :name, :location, :nickname, :image, :participating?, :is_admin }

  it { should reference_many :authentications }
  it { should reference_many :messages }
  it { should reference_many :suggested_projects }
  it { should be_referenced_in(:project).as_inverse_of(:members) }

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
end
