require 'spec_helper'

describe Group do

  describe "associations" do
    it { should belong_to :authentication }
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :meetup_id }
    it { should validate_uniqueness_of :meetup_link }
  end

  describe "attributes" do
    it { should respond_to :user_id }
    it { should respond_to :slug }
    it { should respond_to :name }
    it { should respond_to :description }

    # External links
    it { should respond_to :facebook_link }
    it { should respond_to :twitter_link }
    it { should respond_to :googleplus_link }
    it { should respond_to :other_link }
    it { should respond_to :meetup_link }

    # Geolocation
    it { should respond_to :city }
    it { should respond_to :province }
    it { should respond_to :country }
    it { should respond_to :country_code }
    it { should respond_to :latitude }
    it { should respond_to :longitude }
    it { should respond_to :gmaps }

    # Meetup.com attributes
    it { should respond_to :meetup_id }
    it { should respond_to :organizer_id }
    it { should respond_to :photo_url }
    it { should respond_to :highres_photo_url }
    it { should respond_to :thumbnail_url }
    it { should respond_to :join_mode }
    it { should respond_to :visibility }

    # For scopes
    it { should respond_to :approval }
    it { should respond_to :lsc }

    # Temp attributes
    it { should respond_to :meetup_identifier }

    it { should respond_to :created_at }
    it { should respond_to :updated_at }
  end

  describe "default values" do
    before(:each) do
      @group = Group.new(:name => "Lean Startup Meetup " + Faker::Address.city)
    end

    it { @group.approval.should be_false }
    it { @group.lsc.should be_false }
  end
end