class Team < ActiveRecord::Base
  has_many :sprints, :order => 'sprints.number'
end

# == Schema Information
# Schema version: 20110325172548
#
# Table name: teams
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

