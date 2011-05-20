require 'spec_helper'

describe Project do

  it { should have_fields :name, :description, :slots }

  it { should validate_presence_of :name }
  it { should validate_numericality_of :slots }
  it { should validate_presence_of :originator }

  it { should reference_many :members }
  it { should reference_one(:manager).as_inverse_of(:managed_project) }
  it { should be_referenced_in(:originator).as_inverse_of(:suggested_projects) }
  it { should embed_many :links }

  describe "upcoming" do
    before do
      @active    = Factory(:project, :members => [ Factory(:user, :participating? => true) ])
      @abandoned = Factory(:project)
      @suspended = Factory(:project, :members => [ Factory(:user, :participating? => false) ])
    end

    subject { Project.upcoming }
    it { should include @active }
    it { should_not include @abandoned, @suspended }
  end

  describe "has_vacant_slots?" do
    let(:project) { Factory(:project, :slots => 1) }
    subject { project }

    context "when has" do
      it { should have_vacant_slots }
    end
    
    context "when hasn't" do
      before { project.members << Factory(:user) }
      it { should_not have_vacant_slots }
    end
  end
  
end
