require 'spec_helper'

describe Link do
  
  it { should be_embedded_in :project }
  it { should have_fields :label, :url }
  it { should validate_presence_of :label }
  it { should validate_presence_of :url }
  
end