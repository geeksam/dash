require 'spec_helper'

describe Iteration do
  it 'should have a name' do
    Iteration.new(:number => 42).name.should == 'Iteration #42'
  end

  it "should have a sprint name" do
    sprint = mock_model(Sprint, :name => 'Cherished Mudpuppy')
    Iteration.new(:sprint => sprint).sprint_name.should == 'Cherished Mudpuppy'
  end
end

# == Schema Information
# Schema version: 20110325215449
#
# Table name: iterations
#
#  id         :integer         not null, primary key
#  sprint_id  :integer
#  number     :integer
#  created_at :datetime
#  updated_at :datetime
#

