require "spec_helper"

describe User do

  it { should have_fields :name, :location, :nickname, :image }
  it { should reference_many :authentications }
  it { should validate_presence_of :name }
  it { should validate_presence_of :nickname }

end