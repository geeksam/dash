require 'spec_helper'

describe Goal do
  describe "#points" do
    it 'should be nil when status is NOP' do
      Goal.new(:status => 'NOP').points.should be_nil
    end

    it 'should be 0 when status is FAIL' do
      Goal.new(:status => 'FAIL').points.should == 0
    end

    it 'should be 1 when status is WIN' do
      Goal.new(:status => 'WIN').points.should == 1
    end
  end
end


# == Schema Information
# Schema version: 20110329164257
#
# Table name: goals
#
#  id           :integer         not null, primary key
#  member_id    :integer
#  iteration_id :integer
#  result       :string(255)
#  comments     :text
#  created_at   :datetime
#  updated_at   :datetime
#  status       :string(255)
#

