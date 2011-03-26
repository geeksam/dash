class Goal < ActiveRecord::Base
  belongs_to :iteration
  belongs_to :member

  delegate :name, :to => :member, :prefix => :member, :allow_nil => true
end

# == Schema Information
# Schema version: 20110326040403
#
# Table name: goals
#
#  id           :integer         not null, primary key
#  member_id    :integer
#  iteration_id :integer
#  result       :string(255)
#  nop          :boolean
#  achieved     :boolean
#  comments     :text
#  created_at   :datetime
#  updated_at   :datetime
#

