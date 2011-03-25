class Sprint < ActiveRecord::Base
  belongs_to :team
  has_many :iterations, :order => 'iterations.number'

  def team_name
    team.try(:name)
  end

  def name
    'Sprint #%d' % number
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

