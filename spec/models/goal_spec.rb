require 'spec_helper'

describe Goal do
  pending "add some examples to (or delete) #{__FILE__}"
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

