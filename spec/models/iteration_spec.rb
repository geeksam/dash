require 'spec_helper'

describe Iteration do
  it 'should have a name' do
    Iteration.new(:number => 42).name.should == 'Iteration #42'
  end

  it "should have a sprint name" do
    sprint = mock_model(Sprint, :name => 'Cherished Mudpuppy', :team_members => [])
    Iteration.new(:sprint => sprint).sprint_name.should == 'Cherished Mudpuppy'
  end

  it "should initialize itself with one Goal for each Member of the Sprint('s Team)" do
    abc = alice_bob_and_carol
    sprint = mock_model(Sprint, :team_members => abc)
    iter = Iteration.new(:sprint => sprint)
    iter.goals.map(&:member_name).sort.should == abc.map(&:name).sort
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

