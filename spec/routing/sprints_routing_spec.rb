require "spec_helper"

describe SprintsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/sprints" }.should route_to(:controller => "sprints", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/sprints/1" }.should route_to(:controller => "sprints", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/sprints/1/edit" }.should route_to(:controller => "sprints", :action => "edit", :id => "1")
    end

    it "recognizes and generates #update" do
      { :put => "/sprints/1" }.should route_to(:controller => "sprints", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/sprints/1" }.should route_to(:controller => "sprints", :action => "destroy", :id => "1")
    end

    # Nested resource goo
    context "outside the scope of a team" do
      it "does NOT recognize and generate #new" do
        { :get => "/sprints/new" }.should_not route_to(:controller => "sprints", :action => "new")
        # Unfortunately, it does route with :id => 'new', but I'm not sure I care at the moment. -Sam
      end

      it "does NOT recognize and generate #create" do
        { :post => "/sprints" }.should_not be_routable
      end
    end

    context "in the scope of a team" do
      it "DOES recognize and generate #new" do
        { :get => "teams/1/sprints/new" }.should route_to(:controller => "sprints", :action => "new", :team_id => '1')
      end
    
      it "DOES recognize and generate #create" do
        { :post => "/teams/1/sprints" }.should route_to(:controller => "sprints", :action => "create", :team_id => '1')
      end
    end

  end
end
