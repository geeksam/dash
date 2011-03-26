class Iteration < ActiveRecord::Base
  belongs_to :sprint
  has_many :goals, :order => 'goals.id'

  delegate :name, :to => :sprint, :prefix => :sprint, :allow_nil => true

  def name
    'Iteration #%d' % number
  end

  after_initialize :instantiate_default_goals
  
  def instantiate_default_goals
    return if sprint.blank? # otherwise this fails at least one test, which is probably a code smell
    return unless goals.empty?
    self.goals = sprint.team_members.map { |e| Goal.new(:iteration => self, :member => e) }
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

