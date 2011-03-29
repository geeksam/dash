class Goal < ActiveRecord::Base
  belongs_to :iteration
  belongs_to :member

  STATUSES = %w[WIN FAIL NULL]
  POINT_VALUES = {
    'WIN'  => 1,
    'FAIL' => 0,
  }

  delegate :name, :to => :member, :prefix => :member, :allow_nil => true

  def previous
    iteration.previous_goal_for(member)
  end

  def next
    iteration.next_goal_for(member)
  end

  def prev_goal_summary
    prev_goal = previous
    return 'N/A' if prev_goal.nil? || prev_goal.result.blank?
    '%s (%s)' % [prev_goal.result, prev_goal.status]
  end

  def points
    POINT_VALUES[status]
  end

  def win?
    case status
    when 'WIN'  then true
    when 'FAIl' then false
    when 'NULL' then nil
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

