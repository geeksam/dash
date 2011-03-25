require 'spec_helper'

describe "directory structure" do
  ## These specs exist to keep me from checking in useless crap from the rails generators.
  
  # Using RSpec, not Test::Unit 
  it "should not have a /test directory" do
    Dir.entries(Rails.root).should_not include('test')
  end
  
  # Using /spec/integration in place of /spec/requests
  it "should not have a /spec/requests directory" do
    Dir.entries(File.join(Rails.root, *%w[spec])).should_not include('requests')
  end

  # Controller specs weren't terribly useful once I started deleting routes...
  it "should not have a /spec/controllers directory" do
    Dir.entries(File.join(Rails.root, *%w[spec])).should_not include('controllers')
  end

  # Helpers!  We don't need 'em!  (Delete these specs if, at some point, we do.)
  it "should not have controller-specific helpers" do
    Dir.entries(File.join(Rails.root, *%w[app helpers])).should == %w[. .. application_helper.rb]
  end
  it "should not have a spec/helpers directory (until we actually need one!)" do
    Dir.entries(File.join(Rails.root, *%w[spec])).should_not include('helpers')
  end
end
