require "spec_helper"

describe User do

  it { should have_fields :name, :location, :nickname, :image, :is_admin }

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
  
end
