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
    before(:each) do
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
           @group.link.should == @group.meetup_link }
      it { @group = create :group, :meetup_link => nil
           @group.link.should == @group.facebook_link }
      it { @group = create :group, :meetup_link => nil,
                                   :facebook_link => nil
           @group.link.should == @group.linkedin_link }
      it { @group = create :group, :meetup_link => nil,
                                   :facebook_link => nil,
                                   :linkedin_link => nil
           @group.link.should == @group.googleplus_link }
      it { @group = create :group, :meetup_link => nil,
                                   :facebook_link => nil,
                                   :linkedin_link => nil,
                                   :googleplus_link => nil
           @group.link.should == @group.other_link }
      it { @group = create :group, :meetup_link => nil,
                                   :facebook_link => nil,
                                   :linkedin_link => nil,
                                   :googleplus_link => nil,
                                   :other_link => nil
           @group.link.should == @group.twitter_link }
    end

    describe "address" do
      it { should respond_to :address }
      it { @group = build :group, :province => nil, :country => nil
           @group.address.should == @group.city }
      it { @group = build :group, :city => nil, :country => nil
           @group.address.should == @group.province }
      it { @group = build :group, :city => nil, :province => nil
           @group.address.should == @group.country }
      it { @group = build :group, :country => nil
           @group.address.should == @group.city + ", " +
                                    @group.province }
      it { @group = build :group, :province => nil
           @group.address.should == @group.city + ", " +
                                    @group.country }
      it { @group = build :group, :city => nil
           @group.address.should == @group.province + ", " +
                                    @group.country }
      it { @group = build :group
           @group.address.should == @group.city + ", " +
                                    @group.province + ", " +
                                    @group.country }
      it { @group = build :group, :city => nil, :province => nil, :country => nil
           @group.address.should == "" }
    end

    describe "address_no_country" do
      it { should respond_to :address_no_country }
      it { @group = build :group, :province => nil, :country => nil
           @group.address_no_country.should == @group.city }
      it { @group = build :group, :city => nil, :country => nil
           @group.address_no_country.should == @group.province }
      it { @group = build :group, :city => nil, :province => nil
           @group.address_no_country.should == "" }
      it { @group = build :group, :country => nil
           @group.address_no_country.should == @group.city + ", " +
                                               @group.province }
      it { @group = build :group, :province => nil
           @group.address_no_country.should == @group.city }
      it { @group = build :group, :city => nil
           @group.address_no_country.should == @group.province }
      it { @group = build :group
           @group.address_no_country.should == @group.city + ", " +
                                               @group.province }
      it { @group = build :group, :city => nil, :province => nil, :country => nil
           @group.address_no_country.should == "" }
    end
  end

  describe "meetup api methods" do

    before(:all) do
      RMeetup::Client.api_key = AppConfig['meetup_api_key']
      meetup_response = RMeetup::Client.fetch( :groups,{ :domain => "sanfrancisco.leanstartupcircle.com" })
      RMeetup::Client.stub(:fetch) { meetup_response }
    end

    describe "self.fetch_from_meetup" do
      it { Group.fetch_from_meetup("5555").should == 5 }
    end

    describe "self.fetch_meetups_with_authentication" do
      # TODO: Add some tests here.
    end

    describe "self.save_meeup_api_response" do
      # TODO: Add some tests here.
    end

    describe "self.init_rmeetup" do
      it { Group.should respond_to :init_rmeetup }
      it { Group.init_rmeetup.should_not be_false }
    end
  end
end