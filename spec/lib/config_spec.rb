require 'spec_helper'

describe AppConfig do
  it "should have been merged with private config" do
    AppConfig['twitter']['consumer_key'].should_not eql 'set me in config.private.yml'
  end
end
