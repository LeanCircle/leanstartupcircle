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

  describe "scopes" do
    before do
      @approved_group = create :group, :approval => true
      @unapproved_group = create :group, :approval => false
    end

    context "approved" do
      it { Group.approved == [@approved_group] }
    end
  end

  describe "methods" do
    describe "link" do
      it { should respond_to :link }
      it { @group = create :group
           @group.link.should eql(@group.meetup_link) }
      it { @group = create :group, :meetup_link => nil
           @group.link.should eql(@group.facebook_link) }
      it { @group = create :group, :meetup_link => nil,
                                   :facebook_link => nil
           @group.link.should eql(@group.linkedin_link) }
      it { @group = create :group, :meetup_link => nil,
                                   :facebook_link => nil,
                                   :linkedin_link => nil
           @group.link.should eql(@group.googleplus_link) }
      it { @group = create :group, :meetup_link => nil,
                                   :facebook_link => nil,
                                   :linkedin_link => nil,
                                   :googleplus_link => nil
           @group.link.should eql(@group.other_link) }
      it { @group = create :group, :meetup_link => nil,
                                   :facebook_link => nil,
                                   :linkedin_link => nil,
                                   :googleplus_link => nil,
                                   :other_link => nil
           @group.link.should eql(@group.twitter_link) }
    end
  end
end