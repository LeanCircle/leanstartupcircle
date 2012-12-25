require "spec_helper"

describe "routes for groups:" do

  it "index" do
    get("/groups").should route_to("groups#index")
  end

  it "show" do
    get("/groups/:id").should route_to("groups#show", :id => ":id")
  end

  it "new" do
    get("/groups/new").should route_to("groups#new")
  end

  it "create" do
    post("/groups").should route_to("groups#create")
  end

  it "edit" do
    get("/groups/:id/edit").should raise_error()
  end  

  it "update" do
    put("/groups/:id").should raise_error()
  end

  it "delete" do
    delete("/groups/:id").should raise_error()
  end

  it "organizers" do
    get("/groups/organizers").should route_to("groups#organizers")
  end

end