require 'spec_helper'

describe Project do

  it { should have_fields :name, :description, :slots }

  it { should validate_presence_of :name }
  it { should validate_numericality_of :slots }
  it { should validate_presence_of :originator }

  it { should reference_many :members }
  it { should be_referenced_in(:originator).as_inverse_of(:suggested_projects) }

end
