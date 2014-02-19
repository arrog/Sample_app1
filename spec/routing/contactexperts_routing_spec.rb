require "spec_helper"

describe ContactexpertsController do
  describe "routing" do

    it "routes to #index" do
      get("/contactexperts").should route_to("contactexperts#index")
    end

    it "routes to #new" do
      get("/contactexperts/new").should route_to("contactexperts#new")
    end

    it "routes to #show" do
      get("/contactexperts/1").should route_to("contactexperts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/contactexperts/1/edit").should route_to("contactexperts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/contactexperts").should route_to("contactexperts#create")
    end

    it "routes to #update" do
      put("/contactexperts/1").should route_to("contactexperts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/contactexperts/1").should route_to("contactexperts#destroy", :id => "1")
    end

  end
end
