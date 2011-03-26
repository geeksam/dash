require 'spec_helper'
require 'integration/support'

describe "Iteration goal tracking" do
  before(:each) do
    @iter = Factory.create(:iteration)
    @team = @iter.sprint.team
  end

  it "should have a goals page" do
    visit iteration_path(@iter)
    click_link 'Goals'
    current_path.should == goals_iteration_path(@iter)  # Mmm. RSpec for even, oddly that reads.
  end

  xit "should let me add a goal for a team member" do
    visit goals_iteration_path(@iter)

    click_link "Add Row"

    # get a new row
    # type in the row
    # click "save"
    # check properties of object
    # check contents of page
  end

end
