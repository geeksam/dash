require "spec_helper"

describe IterationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/iterations" }.should route_to(:controller => "iterations", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/iterations/1" }.should route_to(:controller => "iterations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/iterations/1/edit" }.should route_to(:controller => "iterations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #update" do
      { :put => "/iterations/1" }.should route_to(:controller => "iterations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/iterations/1" }.should route_to(:controller => "iterations", :action => "destroy", :id => "1")
    end

    # Nested resource goo
    context "outside the scope of a sprint" do
      it "does NOT recognize and generate #new" do
        { :get => "/iterations/new" }.should_not route_to(:controller => "iterations", :action => "new")
        # Unfortunately, it does route with :id => 'new', but I'm not sure I care at the moment. -Sam
      end

      it "does NOT recognize and generate #create" do
        { :post => "/iterations" }.should_not be_routable
      end
    end

    context "in the scope of a sprint" do
      it "DOES recognize and generate #new" do
        { :get => "sprints/1/iterations/new" }.should route_to(:controller => "iterations", :action => "new", :sprint_id => '1')
      end
    
      it "DOES recognize and generate #create" do
        { :post => "/sprints/1/iterations" }.should route_to(:controller => "iterations", :action => "create", :sprint_id => '1')
      end
    end

  end
end
