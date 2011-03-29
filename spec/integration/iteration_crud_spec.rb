require 'spec_helper'
require 'integration/support'

describe "Iteration CRUD" do
  before(:each) do
    @sprint = Factory.create(:sprint)
    @iteration = Factory.create(:iteration, :sprint => @sprint)
  end
  
  describe "show page" do
    before(:each) do
      visit iteration_path(@iteration)
    end
  
    it "should have the sprint name" do
      page.should have_content(@sprint.name)
    end
  
    it "should have the iteration name" do
      page.should have_content(@iteration.name)
    end
  end
  
  describe "creating a new iteration (scoped to a sprint)" do
    it "should be possible" do
      visit sprint_path(@sprint)
      click_link "New Iteration"
      current_path.should == new_sprint_iteration_path(@sprint)

      fill_in 'Number', :with => 23

      lambda { click_button 'Create Iteration' } \
        .should change(Iteration, :count).by(1)

      iter = Iteration.last
      iter.sprint.should == @sprint
      current_path.should == iteration_path(iter)
    end
    
    it "should let you set up goals from the get-go" do
      pending
    end
  end
end
