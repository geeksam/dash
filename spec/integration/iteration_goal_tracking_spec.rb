require 'spec_helper'
require 'integration/support'

describe "Iteration goal tracking" do
  before(:each) do
    @team = Factory.create(:team, :member_names => 'Alice, Bob')
    @amy, @bob = *@team.members
    @sprint = Factory.create(:sprint, :team => @team)
    @i1 = Factory.create(:iteration, :sprint => @sprint)
    @i2 = @i1.next_iteration(:create => true)

    [@i1, @i2].each { |e| e.save_goals; e.reload }

    @i1_amy = @i1.goal_for(@amy)
    @i1_bob = @i1.goal_for(@bob)
    @i2_amy = @i2.goal_for(@amy)
    @i2_bob = @i2.goal_for(@bob)

    @i1_amy.update_attributes(:result => 'Do some stuff', :status => 'WIN')
    @i1_bob.update_attributes(:result => 'Sit on me bum', :status => 'NULL', :comments => 'what a slacker')
    @i2_amy.update_attributes(:result => 'Do something really ambitious', :status => 'FAIL', :comments => 'doomed to failure!')
    @i2_bob.update_attributes(:result => 'Put cover on TPS report', :status => 'WIN')

    @i2_amy.previous.should == @i1_amy
    @i2_bob.previous.should == @i1_bob
  end

  describe "Iteration show page" do
    it "should show fields we care about" do
      fields_we_care_about = %w[member_name prev_goal_summary result status comments]
      [@i1, @i2].each do |iteration|
        visit iteration_path(iteration)
        iteration.goals.each do |goal|
          fields_we_care_about.each do |field|
            within("#goal_#{goal.id} .#{field}") do
              text.should include(goal.send(field).to_s)
            end
          end
        end
      end
    end

    it "should have the iteration's points ratio" do
      visit iteration_path(@i1)
      page.should have_content(@i1.points_ratio)

      visit iteration_path(@i2)
      page.should have_content(@i2.points_ratio)
    end

    it "should have the sprint's points ratio" do
      visit iteration_path(@i1)
      page.should have_content(@sprint.points_ratio)
    end
  end

  describe "Iteration edit page" do
    describe "Save and Previous" do
      it "should send you go to the edit page for the previous iteration" do
        visit edit_iteration_path(@i2)
        click_button 'Save and Previous'
        current_path.should == edit_iteration_path(@i1)
      end
      
      it "return you to the edit page for the current iteration if no previous one exists" do
        visit edit_iteration_path(@i1)
        click_button 'Save and Previous'
        current_path.should == edit_iteration_path(@i1)
      end
    end
    
    describe "Save" do
      it "should return you to the edit page for the current iteration" do
        visit edit_iteration_path(@i1)
        click_button 'Save and Next'
        current_path.should == edit_iteration_path(@i2)
      end
      
      it "should save contents" do
        visit edit_iteration_path(@i1)
        within("#goal_#{@i1_amy.id}") do
          fill_in "iteration_goals_attributes_0_result", :with => 'Do something less ambitious'
          select 'WIN', :from => 'iteration_goals_attributes_0_status'
          fill_in "iteration_goals_attributes_0_comments", :with => "Look, you're British, so scale it down a bit."
        end
        click_button 'Save'
        within("#goal_#{@i1_amy.id}") do
          find('#iteration_goals_attributes_0_result'  ).value.should == 'Do something less ambitious'
          find('#iteration_goals_attributes_0_status'  ).value.should == 'WIN'
          find('#iteration_goals_attributes_0_comments').value.should == "Look, you're British, so scale it down a bit."
        end
      end
    end
    
    describe "Save and Next" do
      it "send you to the edit page for the next iteration" do
        visit edit_iteration_path(@i1)
        click_button 'Save and Next'
        current_path.should == edit_iteration_path(@i2)
      end
      
      it "create the next iteration if it does not exist" do
        visit edit_iteration_path(@i2)
        click_button 'Save and Next'
        @i2.reload
        i3 = @i2.next_iteration
        current_path.should == edit_iteration_path(i3)
      end
    end
  end
end
