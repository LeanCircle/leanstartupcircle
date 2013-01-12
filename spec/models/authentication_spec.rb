require "spec_helper"

describe Authentication do
  describe "has associations" do
    it { should belong_to :user }

    describe "have_many groups" do
      it { should have_many :groups }

      describe "scoped to meetup" do
        it { @group = create :group, :organizer_id => "12345"
             @authentication = create :authentication, :provider => "meetup", :uid => "12345"
             @authentication.groups.should include(@group) }
        # TODO: Uncomment this when have an idea how to actually do it in the model.
        #it { @group = create :group, :organizer_id => "12345"
        #     @authentication = create :authentication, :provider => "twitter", :uid => "12345"
        #     @authentication.groups.should_not include(@group) }
      end
    end
  end

  describe "validates correctly" do
    it { should validate_presence_of :uid }
    it { should validate_presence_of :provider }
    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  describe "has attributes" do
    describe "necessary for login" do
      it { should respond_to :user_id }
      it { should respond_to :uid }
      it { should respond_to :provider }
    end

    describe "for making api calls" do
      it { should respond_to :token }
      it { should respond_to :secret }
    end

    describe "for miscellaneous use in views" do
      it { should respond_to :image }
      it { should respond_to :url }
      it { should respond_to :name }
      it { should respond_to :location }
      it { should respond_to :description }
    end

    describe "timestamps" do
      it { should respond_to :created_at }
      it { should respond_to :updated_at }
    end
  end

  describe "has method" do
    describe "self.find_or_create_with_omniauth!" do
      let(:user) { create :user }
      let(:twitter_hash) { OmniAuth::AuthHash.new(build :twitter_hash) }
      let(:meetup_hash) { OmniAuth::AuthHash.new(build :meetup_hash) }
      let(:linkedin_hash) { OmniAuth::AuthHash.new(build :linkedin_hash) }

      describe "with bad input" do
        it { expect { Authentication.find_or_create_with_omniauth!(nil, nil) }.to raise_error(ArgumentError) }
        it { expect { Authentication.find_or_create_with_omniauth!(nil, user) }.to raise_error(ArgumentError) }
      end

      describe "with valid twitter hash" do
        context "and user" do
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).should be_valid }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).user_id.should == user.id }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).name.should == twitter_hash.info.name }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).uid.should == twitter_hash.uid }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).provider.should == twitter_hash.provider }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).token.should == twitter_hash.credentials.token }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).secret.should == twitter_hash.credentials.secret }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).image.should == twitter_hash.info.image }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).url.should == twitter_hash.info.urls.public_profile }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).description.should == twitter_hash.info.description }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash, user).location.should == twitter_hash.info.location }
        end

        context "and no user" do
          it { Authentication.find_or_create_with_omniauth!(twitter_hash).should be_valid }
          it { Authentication.find_or_create_with_omniauth!(twitter_hash).user_id.should == nil }
        end
      end

      describe "with valid meetup hash" do
        before(:each) do
          Group.stub(:fetch_meetups_with_authentication) do
            @group = create :group, :name => "Meetup Group"
          end
        end

        it { Authentication.find_or_create_with_omniauth!(meetup_hash, user).provider.should == "meetup" }
        it { Authentication.find_or_create_with_omniauth!(meetup_hash, user)
             Group.find_by_name("Meetup Group").should be_true }
        it { Authentication.find_or_create_with_omniauth!(twitter_hash, user)
             Group.find_by_name("Meetup Group").should be_false }
        it { Authentication.find_or_create_with_omniauth!(linkedin_hash, user)
             Group.find_by_name("Meetup Group").should be_false }
      end

      describe "with valid linkedin hash" do
        it { Authentication.find_or_create_with_omniauth!(linkedin_hash, user).provider.should == "linkedin" }
      end
    end
  end
end