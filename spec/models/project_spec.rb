require 'spec_helper'

describe Project do

  it { should have_fields :name, :description, :slots }

  it { should validate_presence_of :name }
  it { should validate_numericality_of :slots }

  it { should reference_many :members }

end
