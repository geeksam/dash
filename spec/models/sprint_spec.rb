require 'spec_helper'

def iteration_with(attrs = {})
  mock_model(Iteration, attrs)
end

describe Sprint do
  it 'should have a name' do
    Sprint.new(:number => 42).name.should == 'Sprint #42'
  end

  it "should have a team name" do
    team = mock_model(Team, :name => 'Team Spam')
    Sprint.new(:team => team).team_name.should == 'Team Spam'
  end

  describe "#points_ratio" do
    before(:each) do
      @s = Sprint.new
    end

    it "should be 0:0 when there are no iterations" do
      @s.points_ratio.should == '0:0'
    end

    it "should be 1:0 with one iteration of 1:0" do
      @s.stub!(:iterations => [iteration_with(:points_ratio => '1:0')])
      @s.points_ratio.should == '1:0'
    end

    it "should be 1:2 with one iteration of 1:2" do
      @s.stub!(:iterations => [iteration_with(:points_ratio => '1:2')])
      @s.points_ratio.should == '1:2'
    end

    it "should be 5:3 with one iteration of 1:2 and one iteration of 4:1" do
      @s.stub!(:iterations => [iteration_with(:points_ratio => '1:2'), iteration_with(:points_ratio => '4:1')])
      @s.points_ratio.should == '5:3'
    end
  end
end


# == Schema Information
# Schema version: 20110325172548
#
# Table name: sprints
#
#  id         :integer         not null, primary key
#  team_id    :integer
#  number     :integer
#  starts_on  :date
#  ends_on    :date
#  created_at :datetime
#  updated_at :datetime
#

