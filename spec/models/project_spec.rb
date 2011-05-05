require 'spec_helper'

describe Project do
  it { should have_fields :name, :description, :slots_number }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :slots_number }
  it { should validate_numericality_of :slots_number }
end
