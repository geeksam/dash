require 'spec_helper'
require 'integration/support'

describe "Sprint CRUD" do
  before(:each) do
    @dust_bunnies = Factory.create(:team, :name => 'Glorious Dustbunnies')
    @sprint = Factory.create(:sprint, :team => @dust_bunnies)
    @iter = Factory.create(:iteration, :sprint => @sprint)
  end

  describe "index page (scoped to team)" do
    before(:each) do
      visit team_sprints_path(@dust_bunnies)
    end

    it "should have the team name" do
      page.should have_content("Sprints for team: #{@dust_bunnies.name}")
    end
    
    it "should list sprints for the given team" do
      page.should have_content(@dust_bunnies.sprints.first.name)
    end
  end
  
  describe "show page" do
    before(:each) do
      visit sprint_path(@sprint)
    end
  
    it "should have the team name" do
      page.should have_content(@dust_bunnies.name)
    end

    it "should have the sprint name" do
      page.should have_content(@sprint.name)
    end

    it "should link to iterations for the team" do
      page.should have_content(@iter.name)
      click_link @iter.name
      current_path.should == iteration_path(@iter)
    end
  end

  describe "creating a new sprint (scoped to a team)" do
    it "should be possible" do
      visit team_sprints_path(@dust_bunnies)
      click_link "New Sprint"
      fill_in 'Number', :with => 42
      
      lambda { click_button 'Create Sprint' } \
        .should change(Sprint, :count).by(1)

      current_path.should == sprint_path(Sprint.last)
    end
  end
end
