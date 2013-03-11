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
      RMeetup::Client.api_key = ENV['MEETUP_API_KEY']
      @single_response = RMeetup::Client.fetch( :groups,{ :domain => "sanfrancisco.leanstartupcircle.com" })
      @multiple_responses = RMeetup::Client.fetch( :groups,{ :organizer_id => "10786373" })
      @no_response = RMeetup::Client.fetch( :groups,{ :organizer_id => "1" })
    end

    describe "self.fetch_from_meetup" do
      # TODO: Not able to figure out how to really use fake web to stub out responses. Not sure how to test.
    end

    describe "self.fetch_meetups_with_authentication" do
      describe "with multiple responses" do
        before(:each) do
          RMeetup::Client.stub(:fetch).and_return(@multiple_responses)
        end

        it { Group.fetch_meetups_with_authentication(create :authentication).count.should == @multiple_responses.count}
        it { Group.fetch_meetups_with_authentication(create :authentication).first.class.should == Group.new.class }
        it { Group.fetch_meetups_with_authentication(create :authentication)
             Group.find_by_name(@multiple_responses.first.name).should be_true }
      end

      describe "with one response" do
        before(:each) do
          RMeetup::Client.stub(:fetch).and_return(@single_response)
        end

        it { Group.fetch_meetups_with_authentication(create :authentication).count.should == 1 }
        it { Group.fetch_meetups_with_authentication(create :authentication).first.class.should == Group.new.class }
        it { Group.fetch_meetups_with_authentication(create :authentication)
             Group.find_by_name(@single_response.first.name).should be_true }
      end

      describe "with no response" do
        before(:each) do
          RMeetup::Client.stub(:fetch).and_return(@no_response)
        end

        it { Group.fetch_meetups_with_authentication(create :authentication).count.should == 0 }
      end

      describe "with bad response" do
        before(:each) do
          bad_response = `curl -is https://api.meetup.com/2/groups?key=4404a5c4f33d2771b2d67175c2772&sign=true&category_id=1AAAAAA&page=20`
          FakeWeb.register_uri(:any, %r|http://api\.meetup\.com/|, :page => bad_response)
        end

        it { Group.fetch_meetups_with_authentication(create :authentication).count.should == 0 }
      end

    end

    describe "self.create_from_meetup_api_response" do
      before(:all) do
        @response = @single_response.first
        FakeWeb.register_uri(:any, %r|http://maps\.googleapis\.com/maps/api/geocode|, :body => SF_LSC_GEOCODE_JSON)
      end

      shared_examples_for "testing group should have values of meetup response" do |group|
        describe "group should have values from meetup response" do
          it { Group.create_from_meetup_api_response(@response).description.should == @response.description }
          it { Group.create_from_meetup_api_response(@response).meetup_id.should == @response.id }
          it { Group.create_from_meetup_api_response(@response).organizer_id.should == @response.organizer["member_id"] }
          it { Group.create_from_meetup_api_response(@response).meetup_link.should == @response.link }
          it { Group.create_from_meetup_api_response(@response).city.should == @response.city }
          it { Group.create_from_meetup_api_response(@response).province.should == @response.state }
          it { Group.create_from_meetup_api_response(@response).country_code.should == @response.country }
          it { Group.create_from_meetup_api_response(@response).latitude.should == @response.lat }
          it { Group.create_from_meetup_api_response(@response).longitude.should == @response.lon }
          it { Group.create_from_meetup_api_response(@response).photo_url.should == @response.group_photo["photo_link"] }
          it { Group.create_from_meetup_api_response(@response).highres_photo_url.should == @response.group_photo["highres_link"] }
          it { Group.create_from_meetup_api_response(@response).thumbnail_url.should == @response.group_photo["thumb_link"] }
          it { Group.create_from_meetup_api_response(@response).join_mode.should == @response.join_mode }
          it { Group.create_from_meetup_api_response(@response).visibility.should == @response.visibility }
        end
      end

      shared_examples_for "testing for missing data in meetup response" do |group|
        describe "if missing data in meetup response" do
          it { @response.stub(:description) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:id) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:link) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:organizer) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.organizer.stub(:[], "member_id") { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:city) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:state) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:country) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:lat) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:lon) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:group_photo) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.group_photo.stub(:[], "highres_link") { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.group_photo.stub(:[], "photo_link") { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.group_photo.stub(:[], "thumb_link") { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:join_mode) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
          it { @response.stub(:visibility) { nil }
               Group.create_from_meetup_api_response(@response).should be_valid }
        end
      end
    end

    describe "self.init_rmeetup" do
      it { Group.init_rmeetup.should_not be_false }
      it { Group.init_rmeetup.should == ENV['MEETUP_API_KEY'] }
    end

    describe "clean_query" do
      it { Group.clean_query("http://bob.com").should == "bob.com" }
      it { Group.clean_query("http://bob.com/").should == "bob.com" }
      it { Group.clean_query("http://bob.com//").should == "bob.com" }
      it { Group.clean_query("bob.com").should == "bob.com" }
    end

    describe "query_method" do
      it { Group.query_method("12345").should == :group_id }
      it { Group.query_method("meetup.com/leaner").should == :group_urlname }
      it { Group.query_method("leaner.com").should == :domain }
    end
  end
end