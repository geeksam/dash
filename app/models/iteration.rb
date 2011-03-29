class Iteration < ActiveRecord::Base
  belongs_to :sprint
  has_many :goals, :order => 'goals.id'
  accepts_nested_attributes_for :goals

  delegate :name, :points_ratio, :to => :sprint, :prefix => :sprint, :allow_nil => true

  def name
    'Iteration #%d' % number
  end

  before_create :instantiate_default_goals
  after_initialize :instantiate_default_goals

  def save_goals
    goals.each(&:save)
  end

  def instantiate_default_goals
    return unless goals.empty?
    return if sprint.blank? # otherwise this fails at least one test, which is probably a code smell
    self.goals = sprint.team_members.map { |e| Goal.new(:iteration => self, :member => e) }.shuffle
  end

  def previous_iteration
    idx = sprint.iterations.index(self)
    (idx.nil? || idx == 0) ? nil : sprint.iterations[idx - 1]
  end

  def next_iteration(options = {})
    idx = sprint.iterations.index(self)
    the_next = sprint.iterations[idx + 1]
    if the_next.nil? && (options[:initialize] || options[:create])
      the_next = Iteration.new(:sprint => sprint, :number => number + 1)
      the_next.save if options[:create]
    end
    the_next
  end

  def previous_goal_for(member)
    previous_iteration.try(:goal_for, member)
  end

  def next_goal_for(member, options = {})
    previous_iteration(options).try(:goal_for, member)
  end

  def goal_for(team_member)
    goals.detect { |goal| goal.member == team_member }
  end

  def points_ratio
    wins_and_fails.join(':')
  end

  def wins_and_fails
    goals.map(&:points).compact.partition { |e| e > 0 }.map(&:length)
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

