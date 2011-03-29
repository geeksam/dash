require 'spec_helper'

def goal_with_points(points_value)
  mock_model(Goal, :points => points_value)
end

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

  describe "#previous_iteration" do
    before(:each) do
      @sprint = mock_model(Sprint, :team_members => [])
      @i1 = Iteration.new(:sprint => @sprint)
      @i2 = Iteration.new(:sprint => @sprint)
      @sprint.stub!(:iterations => [@i1, @i2])
    end

    it "should return nil when it is the first iteration in its sprint" do
      @i1.previous_iteration.should be_nil
    end

    it "should return the previous iteration when it is not the first iteration in its sprint" do
      @i2.previous_iteration.should == @i1
    end
  end

  describe "#next_iteration" do
    before(:each) do
      @sprint = mock_model(Sprint, :team_members => [])
      @i1 = Iteration.new(:sprint => @sprint, :number => 1)
      @i2 = Iteration.new(:sprint => @sprint, :number => 2)
      @sprint.stub!(:iterations => [@i1, @i2])
    end

    it "should return nil when the receiver is the last in its sprint" do
      @i2.next_iteration.should be_nil
    end

    it "should return the next iteration when the receiver is not the last in its sprint" do
      @i1.next_iteration.should == @i2
    end

    it "should instantiate the next iteration when the receiver is the last in its sprint and is sent :initialize => true" do
      i3 = @i2.next_iteration(:initialize => true)
      i3.should be_kind_of(Iteration)
      i3.should be_new_record
    end

    it "should create the next iteration when the receiver is the last in its sprint and is sent :create => true" do
      i3 = @i2.next_iteration(:create => true)
      i3.should be_kind_of(Iteration)
      i3.should_not be_new_record
    end

    it "should return the next (existing!) iteration when the receiver is not the last in its sprint and is sent :create => true" do
      @i1.next_iteration(:create => true).should == @i2
    end
  end

  describe "points_ratio" do
    it "should be 0:0 when there are no goals" do
      i = Iteration.new
      i.stub!(:goals => [])
      i.points_ratio.should == '0:0'
    end

    it "should be 0:0 when there are no wins or fails (but some NOPs)" do
      i = Iteration.new
      i.stub!(:goals => [goal_with_points(nil)])
      i.points_ratio.should == '0:0'
    end

    it "should be 1:0 when there is one WIN" do
      i = Iteration.new
      i.stub!(:goals => [goal_with_points(1)])
      i.points_ratio.should == '1:0'
    end

    it "should be 0:1 when there is one FAIL" do
      i = Iteration.new
      i.stub!(:goals => [goal_with_points(0)])
      i.points_ratio.should == '0:1'
    end

    it "should be 1:1 when there are two WINs, one FAIL, and a NOP" do
      i = Iteration.new
      i.stub!(:goals => [goal_with_points(1), goal_with_points(0), goal_with_points(1), goal_with_points(nil)])
      i.points_ratio.should == '2:1'
    end
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

