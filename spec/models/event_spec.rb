require 'spec_helper'

describe Event do
  it { should have_fields :date, :time, :address, :phone, :map_link }
  it { should validate_presence_of :date }
end
