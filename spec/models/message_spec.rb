require 'spec_helper'

describe Message do
  it { should have_field :body }
  it { should validate_presence_of :body }

  it { should belong_to :author }
  it { should validate_presence_of :author_id }
end
