require 'spec_helper'
require 'integration/support'

describe "Sprint CRUD" do
  before(:each) do
    @team = Factory.create(:team, :name => 'Glorious Dustbunnies')
    @sprint = Factory.create(:sprint, :team => @team)
  end

  describe "show page" do
    before(:each) do
      visit sprint_path(@sprint)
    end

    it "should have the team name" do
      page.should have_content(@team.name)
    end

    it "should have the sprint name" do
      page.should have_content(@sprint.name)
    end

    it "should link to iterations for the team" do
      iter = Factory.create(:iteration, :sprint => @sprint)
      visit sprint_path(@sprint)
      page.should have_content(iter.name)
      click_link iter.name
      current_path.should == iteration_path(iter)
    end
  end

  describe "creating a new sprint (scoped to a team)" do
    it "should be possible" do
      visit team_path(@team)
      click_link "New Sprint"
      current_path.should == new_team_sprint_path(@team)

      fill_in 'Number', :with => 42

      lambda { click_button 'Create Sprint' } \
        .should change(Sprint, :count).by(1)

      sprint = Sprint.last
      sprint.team.should == @team
      current_path.should == sprint_path(sprint)
    end
  end
end
