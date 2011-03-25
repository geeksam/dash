require "spec_helper"

describe SprintsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/sprints" }.should route_to(:controller => "sprints", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/sprints/new" }.should route_to(:controller => "sprints", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/sprints/1" }.should route_to(:controller => "sprints", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/sprints/1/edit" }.should route_to(:controller => "sprints", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/sprints" }.should route_to(:controller => "sprints", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/sprints/1" }.should route_to(:controller => "sprints", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/sprints/1" }.should route_to(:controller => "sprints", :action => "destroy", :id => "1")
    end

  end
end
