require 'spec_helper'

describe Sprint do
  it 'should have a name' do
    Sprint.new(:number => 42).name.should == 'Sprint #42'
  end

  it "should have a team name" do
    team = mock_model(Team, :name => 'Team Spam')
    Sprint.new(:team => team).team_name.should == 'Team Spam'
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

