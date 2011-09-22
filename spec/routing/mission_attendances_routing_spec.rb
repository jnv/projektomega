require "spec_helper"

describe MissionAttendancesController do
  describe "routing" do

    it "routes to #index" do
      get("/reports").should route_to("mission_attendances#index")
    end

    it "routes to #new" do
      get("/reports/new").should_not route_to("mission_attendances#new")
    end

    it "routes to #show" do
      get("/reports/1,1").should route_to("mission_attendances#show", :id => "1,1")
    end

    it "routes to #edit" do
      get("/reports/1,1/edit").should route_to("mission_attendances#edit", :id => "1,1")
    end

    #it "routes to #create" do
    #  post("/reports").should_not route_to("mission_attendances#create")
    #end

    it "routes to #update" do
      put("/reports/1,1").should route_to("mission_attendances#update", :id => "1,1")
    end

    #it "routes to #destroy" do
    #  delete("/reports/1,1").should_not route_to("mission_attendances#destroy", :id => "1,1")
    #end

  end
end
