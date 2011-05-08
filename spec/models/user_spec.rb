require "spec_helper"

describe User do
  specify { Factory.build(:user).should be_valid }
end