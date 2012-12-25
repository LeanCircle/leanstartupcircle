require "spec_helper"

describe "routes for users:" do

  it "index" do
    get("/users").should route_to("users#index")
  end

  it "show" do
    get("/users/:id").should route_to("users#show", :id => ":id")
  end

  it "new" do
    get("/users/new").should raise_error()
  end

  it "create" do
    post("/users").should raise_error()
  end

  it "edit" do
    get("/users/:id/edit").should raise_error()
  end  

  it "update" do
    put("/users/:id").should raise_error()
  end

  it "delete" do
    delete("/users/:id").should raise_error()
  end

end