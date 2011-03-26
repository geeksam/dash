class Team < ActiveRecord::Base
  has_many :members, :order => 'members.name'
  has_many :sprints, :order => 'sprints.number'

  def member_names
    members.map(&:name)
  end
  def member_names=(*names)
    members.destroy_all
    self.members = names.
      join(', ').
      strip.
      split(/,\s*/).
      map { |name| Member.create!(:team => self, :name => name) }
  end
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

