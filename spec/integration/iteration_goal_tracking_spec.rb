require 'spec_helper'
require 'integration/support'

describe "Iteration goal tracking" do
  before(:each) do
    @iter = Factory.create(:iteration)
    @team = @iter.sprint.team
    @team.members = alice_bob_and_carol
    @team.members.each(&:save)
  end

  pending "Iteration planning"
  pending "Iteration review"
end
