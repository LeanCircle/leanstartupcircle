require "spec_helper"

describe "routes for static pages:" do

  it "guidelines" do
    get("/guidelines").should route_to("static_pages#guidelines")
  end

  it "team" do
    get("/team").should route_to("static_pages#team")
  end

  it "moderation_guidelines" do
    get("/moderation_guidelines").should route_to("static_pages#moderation_guidelines")
  end

end