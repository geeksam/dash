class Iteration < ActiveRecord::Base
  belongs_to :sprint
  has_many :goals, :order => 'goals.id'

  def name
    'Iteration #%d' % number
  end
  
  def sprint_name
    sprint.try(:name)
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

