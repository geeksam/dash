class Member < ActiveRecord::Base
  belongs_to :team
end

# == Schema Information
# Schema version: 20110326040403
#
# Table name: members
#
#  id         :integer         not null, primary key
#  team_id    :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

