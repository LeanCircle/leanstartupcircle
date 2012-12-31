require "spec_helper"

describe Authentication do

  describe "associations:" do
    it { should belong_to :user }

    describe "should have_many groups" do
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

  describe "validations:" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :provider }

    describe "uniqueness of uid" do
      it { should validate_uniqueness_of :uid }
      it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
      describe "scoped to provider" do
        it { @authentication1 = create :authentication, :provider => "twitter", :uid => "12345"
             @authentication2 = build :authentication, :provider => "twitter", :uid => "12345"
             @authentication2.should_not be_valid }
        it { @authentication1 = create :authentication, :provider => "twitter", :uid => "12345"
             @authentication2 = build :authentication, :provider => "meetup", :uid => "12345"
             @authentication2.should be_valid }
      end
    end
  end

  describe "attributes:" do
    describe "necessary for login" do
      it { should respond_to :user_id }
      it { should respond_to :uid }
      it { should respond_to :provider }
    end

    describe "keys" do
      it { should respond_to :token }
      it { should respond_to :secret }
    end

    describe "miscellaneous" do
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

  describe "methods:" do
    describe "self.create_with_omniauth!:" do
      before(:each) do
        @omniauth_twitter = { 'info' => { 'name' => 'Fred Flintstone',
                                          'image' => 'http://image.com/image.jpg',
                                          'urls' => { 'public_profile' => 'http://homeurl.com/username' },
                                          'email' => 'dpsk@email.ru',
                                          'description' => 'This is who I am.',
                                          'location' => 'New York, NY' },
                              'uid' => '12345',
                              'provider' => 'twitter',
                              'credentials' => {'token' => 'token', 'secret' => 'secret'},
                              'extra' => { 'user_hash' => {} } }
        @twitter_hash = OmniAuth::AuthHash.new(@omniauth_twitter)
        @user = create(:user)
      end

      describe "with bad input" do
        it { expect { Authentication.create_with_omniauth!(nil, nil) }.to raise_error(ArgumentError) }
        it { expect { Authentication.create_with_omniauth!("Hello", nil) }.to raise_error(ArgumentError) }
        it { expect { Authentication.create_with_omniauth!(nil, @user) }.to raise_error(ArgumentError) }
        it { expect { Authentication.create_with_omniauth!(@twitter_hash, nil) }.to raise_error(ArgumentError) }
      end

      describe "with valid twitter hash" do
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).should be_valid }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).user_id.should == @user.id }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).name.should == "Fred Flintstone" }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).uid.should == "12345" }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).provider.should == "twitter" }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).token.should == "token" }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).secret.should == "secret" }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).image.should == "http://image.com/image.jpg" }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).url.should == "http://homeurl.com/username" }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).description.should == "This is who I am." }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user).location.should == "New York, NY" }
      end

      describe "with valid meetup hash" do
        before(:each) do
          @omniauth_meetup = { 'info' => { 'name' => 'Fred Flintstone',
                                           'image' => 'http://image.com/image.jpg',
                                           'urls' => { 'public_profile' => 'http://homeurl.com/username' },
                                           'email' => 'dpsk@email.ru',
                                           'description' => 'This is who I am.',
                                           'location' => 'New York, NY' },
                               'uid' => '12345',
                               'provider' => 'meetup',
                               'credentials' => {'token' => 'token', 'secret' => 'secret'},
                               'extra' => { 'user_hash' => {} } }
          @meetup_hash = OmniAuth::AuthHash.new(@omniauth_meetup)
          Group.stub(:fetch_meetups_with_authentication) do
            @group = create :group, :name => "Meetup Group"
          end
        end
        it { Authentication.create_with_omniauth!(@meetup_hash, @user).provider.should == "meetup" }
        it { Authentication.create_with_omniauth!(@meetup_hash, @user)
             Group.find_by_name("Meetup Group").should be_true }
        it { Authentication.create_with_omniauth!(@twitter_hash, @user)
             Group.find_by_name("Meetup Group").should be_false }
      end
    end
  end
end