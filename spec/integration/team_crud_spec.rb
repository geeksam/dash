require 'spec_helper'
require 'integration/support'

describe "Team CRUD" do
  before(:each) do
    @team = Factory.create(:team, :name => 'Glorious Dustbunnies')
  end
  
  describe "index page" do
    it "should list teams" do
      visit teams_path
      page.should have_content(@team.name)
    end
  end
  
  describe "show page" do
    it "should have the team name" do
      visit team_path(@team)
      page.should have_content(@team.name)
    end
    
    it "should link to sprints for the team" do
      s = Factory.create(:sprint, :team => @team)
      visit team_path(@team)
      click_link s.name
      current_path.should == sprint_path(s)
    end
  end

  describe "creating a new team" do
    it "should be possible" do
      visit teams_path
      click_link "New Team"
      fill_in 'Name', :with => 'Weasels United'

      lambda {
        click_button "Create Team"
      }.should change(Team, :count).by(1)
      
      weasels = Team.last
      current_path.should == team_path(weasels)
    end
  end

end
