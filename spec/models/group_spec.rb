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

  describe "attributes:" do
    describe "primary" do
      it { should respond_to :user_id }
      it { should respond_to :slug }
      it { should respond_to :name }
      it { should respond_to :description }
    end

    describe "external links" do
      it { should respond_to :facebook_link }
      it { should respond_to :twitter_link }
      it { should respond_to :googleplus_link }
      it { should respond_to :other_link }
      it { should respond_to :meetup_link }
    end

    describe "(geo)location" do
      it { should respond_to :city }
      it { should respond_to :province }
      it { should respond_to :country }
      it { should respond_to :country_code }
      it { should respond_to :latitude }
      it { should respond_to :longitude }
      it { should respond_to :gmaps }
    end

    describe "meetup.com" do
      it { should respond_to :meetup_id }
      it { should respond_to :organizer_id }
      it { should respond_to :photo_url }
      it { should respond_to :highres_photo_url }
      it { should respond_to :thumbnail_url }
      it { should respond_to :join_mode }
      it { should respond_to :visibility }
    end

    describe "used in scopes" do
      it { should respond_to :approval }
      it { should respond_to :lsc }
    end

    describe "temp" do
      it { should respond_to :meetup_identifier }
    end

    describe "timestamps" do
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

  describe "scopes" do
    before(:each) do
      @approved_group = create :group, :approval => true
      @unapproved_group = create :group, :approval => false
    end

    context "approved" do
      it { Group.approved == [@approved_group] }
    end
  end

  describe "methods:" do
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

  describe "meetup api methods:" do

    before(:all) do
      RMeetup::Client.api_key = AppConfig['meetup_api_key']
      @single_response = RMeetup::Client.fetch( :groups,{ :domain => "sanfrancisco.leanstartupcircle.com" })
      @multiple_responses = RMeetup::Client.fetch( :groups,{ :domain => "sanfrancisco.leanstartupcircle.com" })
    end

    describe "self.fetch_from_meetup" do
      # TODO: Add some tests here.
    end

    describe "self.fetch_meetups_with_authentication" do
      # TODO: Add some tests here.
    end

    describe "self.update_or_create_from_meetup_api_response" do
      before(:all) do
        @response = @multiple_responses.first
        FakeWeb.register_uri(:any, %r|http://maps\.googleapis\.com/maps/api/geocode|, :body => SF_LSC_GEOCODE_JSON)
      end

      shared_examples_for "testing group should have values of meetup response" do |group|
        describe "group should have values from meetup response" do
          it { Group.update_or_create_from_meetup_api_response(@response, group).description.should == @response.description }
          it { Group.update_or_create_from_meetup_api_response(@response, group).meetup_id.should == @response.id }
          it { Group.update_or_create_from_meetup_api_response(@response, group).organizer_id.should == @response.organizer["member_id"] }
          it { Group.update_or_create_from_meetup_api_response(@response, group).meetup_link.should == @response.link }
          it { Group.update_or_create_from_meetup_api_response(@response, group).city.should == @response.city }
          it { Group.update_or_create_from_meetup_api_response(@response, group).province.should == @response.state }
          it { Group.update_or_create_from_meetup_api_response(@response, group).country_code.should == @response.country }
          it { Group.update_or_create_from_meetup_api_response(@response, group).latitude.should == @response.lat }
          it { Group.update_or_create_from_meetup_api_response(@response, group).longitude.should == @response.lon }
          it { Group.update_or_create_from_meetup_api_response(@response, group).photo_url.should == @response.group_photo["photo_link"] }
          it { Group.update_or_create_from_meetup_api_response(@response, group).highres_photo_url.should == @response.group_photo["highres_link"] }
          it { Group.update_or_create_from_meetup_api_response(@response, group).thumbnail_url.should == @response.group_photo["thumb_link"] }
          it { Group.update_or_create_from_meetup_api_response(@response, group).join_mode.should == @response.join_mode }
          it { Group.update_or_create_from_meetup_api_response(@response, group).visibility.should == @response.visibility }
        end
      end

      shared_examples_for "testing for missing data in meetup response" do |group|
        describe "if missing data in meetup response" do
          it { @response.stub(:description) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:id) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:link) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:organizer) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.organizer.stub(:[], "member_id") { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:city) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:state) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:country) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:lat) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:lon) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:group_photo) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.group_photo.stub(:[], "highres_link") { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.group_photo.stub(:[], "photo_link") { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.group_photo.stub(:[], "thumb_link") { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:join_mode) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
          it { @response.stub(:visibility) { nil }
               Group.update_or_create_from_meetup_api_response(@response, group).should be_valid }
        end
      end

      describe "if response is blank" do
        it { Group.update_or_create_from_meetup_api_response(nil).should == false }
        it { Group.update_or_create_from_meetup_api_response("").should == false }
      end

      describe "if response is valid and no group passed in" do
        it { Group.update_or_create_from_meetup_api_response(@response).should be_valid }
        it { Group.update_or_create_from_meetup_api_response(@response).class.should == Group.new.class }

        include_examples "testing group should have values of meetup response"
        it { Group.update_or_create_from_meetup_api_response(@response).name.should == @response.name }

        include_examples "testing for missing data in meetup response"
        it { @response.stub(:name) { nil }
             Group.update_or_create_from_meetup_api_response(@response).should == false }
      end

      describe "if response is valid and group passed in" do
        before(:each) do
          @group = create :group
        end

        it { Group.update_or_create_from_meetup_api_response(@response, @group).should be_valid }
        it { Group.update_or_create_from_meetup_api_response(@response, @group).class.should == Group.new.class }

        include_examples "testing group should have values of meetup response", @group
        it { Group.update_or_create_from_meetup_api_response(@response, @group).name.should_not == @response.name }
        it { original_name = @group.name
             Group.update_or_create_from_meetup_api_response(@response, @group).name.should == original_name }

        include_examples "testing for missing data in meetup response", @group
        it { @response.stub(:name) { nil }
             Group.update_or_create_from_meetup_api_response(@response, @group).should be_valid }
      end
    end

    describe "self.init_rmeetup" do
      it { Group.should respond_to :init_rmeetup }
      it { Group.init_rmeetup.should_not be_false }
      it { Group.init_rmeetup.should == AppConfig['meetup_api_key'] }
    end
  end
end