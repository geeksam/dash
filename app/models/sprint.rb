class Sprint < ActiveRecord::Base
  belongs_to :team
  has_many :iterations, :order => 'iterations.number'

  delegate :name, :members, :to => :team, :prefix => :team, :allow_nil => true

  def name
    'Sprint #%d' % number
  end

  def points_ratio
    return '0:0' if iterations.empty?
    iterations.
      map { |e| e.points_ratio.split(':').map(&:to_i) }.
      transpose.
      map(&:sum).
      join(':')
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

