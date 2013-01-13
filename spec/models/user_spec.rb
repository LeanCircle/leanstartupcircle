require "spec_helper"

describe User do

  describe "associations" do
    it { should have_many :authentications }
    it { should have_many :groups }
  end

  describe "validations" do
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :email }
    it { @user1 = create :user, :email => "test@test.com"
         @user2 = build :user, :email => "test@test.com"
         @user2.should_not be_valid }
    it { @user1 = create :user, :email => "test@test.com"
         @user2 = build :user, :email => "TEST@test.com"
         @user2.should_not be_valid }
  end

  describe "attributes:" do
    describe "primary" do
      it { should respond_to :slug }
      it { should respond_to :role }
      it { should respond_to :name }
      it { should respond_to :email }
      it { should respond_to :phone }
      it { should respond_to :main_image }
      it { should respond_to :main_description }
      it { should respond_to :main_url }
    end

    describe "devise" do
      it { should respond_to :encrypted_password }
      it { should respond_to :reset_password_token }
      it { should respond_to :reset_password_sent_at }
      it { should respond_to :remember_created_at }
      it { should respond_to :last_sign_in_at }
      it { should respond_to :current_sign_in_ip }
      it { should respond_to :last_sign_in_ip }
      it { should respond_to :confirmation_token }
      it { should respond_to :confirmed_at }
      it { should respond_to :confirmation_sent_at }
      it { should respond_to :unconfirmed_email }
      it { should respond_to :failed_attempts }
      it { should respond_to :unlock_token }
      it { should respond_to :locked_at }
    end

    describe "(geo)location" do
      it { should respond_to :city }
      it { should respond_to :province }
      it { should respond_to :country }
      it { should respond_to :zip_code }
      it { should respond_to :latitude }
      it { should respond_to :longitude }
      it { should respond_to :gmaps }
    end

    describe "timestamps" do
      it { should respond_to :created_at }
      it { should respond_to :updated_at }
    end
  end

  describe "default values" do
    before(:each) do
      @user = User.new
    end

    it { @user.role.should == 'member' }
  end

  describe "scopes" do
    # Just a stub
  end

  describe "methods:" do
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

    describe "image" do
      context "with main_image" do
        it { @auth = create :authentication, :image => nil
             @auth.user.image.should == @auth.user.main_image }
        it { create(:user, :main_image => nil).image.should == nil }
      end

      context "without main_image" do
        before(:each) do
          @auth1 = create :authentication, :image => nil
          @auth2 = create :authentication, :user_id => @auth1.user_id
          @auth3 = create :authentication, :user_id => @auth1.user_id
          @user = @auth1.user
          @user.update_attributes(:main_image => nil)
        end

        it { should respond_to :image }
        it { @user.image.should == @auth2.image }
      end
    end

    describe "description" do
      context "with main_description" do
        it { @auth = create :authentication, :description => nil
             @auth.user.description.should == @auth.user.main_description }
        it { create(:user, :main_description => nil).description.should == nil }
      end

      context "without main_description" do
        before(:each) do
          @auth1 = create :authentication, :description => nil
          @auth2 = create :authentication, :user_id => @auth1.user_id
          @auth3 = create :authentication, :user_id => @auth1.user_id
          @user = @auth1.user
          @user.update_attributes(:main_description => nil)
        end

        it { should respond_to :description }
        it { @user.description.should == @auth2.description }
      end
    end

    describe "url" do
      context "with main_url" do
        it { @auth = create :authentication, :url => nil
             @auth.user.url.should == @auth.user.main_url }
        it { create(:user, :main_url => nil).url.should == nil }
      end

      context "without main_url" do
        before(:each) do
          @auth1 = create :authentication, :url => nil
          @auth2 = create :authentication, :user_id => @auth1.user_id
          @auth3 = create :authentication, :user_id => @auth1.user_id
          @user = @auth1.user
          @user.update_attributes(:main_url => nil)
        end

        it { should respond_to :url }
        it { @user.url.should == @auth2.url }
      end
    end

    describe "first_name" do
      before(:each) do
        @user = create :user, :name => 'Bob the Builder'
      end

      it { should respond_to :first_name }
      it { @user.first_name.should == "Bob" }
      it { @user.name = nil
           @user.first_name.should == "Anonymous" }
      it { @user.name = nil
           @auth1 = create :authentication, :user_id => @user.id, :name => nil
           @auth2 = create :authentication, :user_id => @user.id, :name => "Charlie Checkers"
           @auth3 = create :authentication, :user_id => @user.id
           @user.first_name.should == "Charlie" }
    end

    describe "identifier" do
      before(:each) do
        @user = create :user
      end

      it { should respond_to :identifier }
      it { @user.identifier.should == @user.name }
      it { @user.name = nil
           @user.identifier.should == @user.email }
      it { @user.name = nil
           @auth1 = create :authentication, :user_id => @user.id, :name => nil
           @auth2 = create :authentication, :user_id => @user.id, :name => "Charlie Checkers"
           @auth3 = create :authentication, :user_id => @user.id
           @user.identifier.should == "Charlie Checkers" }
    end

    describe "email_header" do
      it { should respond_to :email_header }
      it { @user = create :user, :name => "Bob", :email => "bob@bob.com"
           @user.email_header.should == '"Bob" <bob@bob.com>' }
    end

    describe "admin?" do
      it { should respond_to :admin? }
      it { @user = create :user, :role => "member"
           @user.admin?.should be_false }
      it { @user = create :user, :role => "admin"
           @user.admin?.should be_true }
    end

    describe "address" do
      it { should respond_to :address }
      it { @user = build :user, :province => nil, :country => nil
           @user.address.should == @user.city }
      it { @user = build :user, :city => nil, :country => nil
           @user.address.should == @user.province }
      it { @user = build :user, :city => nil, :province => nil
           @user.address.should == @user.country }
      it { @user = build :user, :country => nil
           @user.address.should == @user.city + ", " +
                                   @user.province }
      it { @user = build :user, :province => nil
           @user.address.should == @user.city + ", " +
                                   @user.country }
      it { @user = build :user, :city => nil
           @user.address.should == @user.province + ", " +
                                   @user.country }
      it { @user = build :user
           @user.address.should == @user.city + ", " +
                                   @user.province + ", " +
                                   @user.country }
      it { @user = build :user, :city => nil, :province => nil, :country => nil
           @user.address.should == "" }
    end

    describe "gmaps4rails_address" do
      it { should respond_to :gmaps4rails_address }
      it { @user = create :user
           @user.gmaps4rails_address.should == @user.zip_code }
    end

    describe "omniauth methods:" do

      let(:twitter_hash) { OmniAuth::AuthHash.new(build :twitter_hash) }
      let(:meetup_hash) { OmniAuth::AuthHash.new(build :meetup_hash) }
      let(:linkedin_hash) { OmniAuth::AuthHash.new(build :linkedin_hash) }

      describe "find_or_create_with_omniauth!" do
        it { User.should respond_to :find_or_create_with_omniauth! }
        # TODO: Add specs
      end

      describe "create_with_omniauth!" do
        it { User.should respond_to :create_with_omniauth! }

        describe "with bad input" do
          it { expect { User.create_with_omniauth!(nil) }.to raise_error(ArgumentError) }
          it { expect { User.create_with_omniauth!("") }.to raise_error(ArgumentError) }
        end

        describe "with valid twitter hash" do
          it { User.create_with_omniauth!(twitter_hash).should_not be_valid }
          it { User.create_with_omniauth!(twitter_hash).name.should == twitter_hash.info.name }
          it { User.create_with_omniauth!(twitter_hash).main_image.should == twitter_hash.info.image }
          it { User.create_with_omniauth!(twitter_hash).main_url.should == twitter_hash.info.urls.public_profile }
          it { User.create_with_omniauth!(twitter_hash).main_description.should == twitter_hash.info.description }
          #it { User.create_with_omniauth!(twitter_hash).location.should == "New York, NY" }
          it { User.create_with_omniauth!(twitter_hash).email.blank?.should be_true }
        end

        describe "with valid linkedin hash" do
          it { User.create_with_omniauth!(linkedin_hash).should be_valid }
          it { User.create_with_omniauth!(linkedin_hash).email.should == linkedin_hash.info.email }
        end

        describe "with valid twitter hash" do
          it { User.create_with_omniauth!(meetup_hash).should_not be_valid }
        end
      end
    end

    describe "new_with_session" do
      it { User.should respond_to :new_with_session }
      # TODO: Add specs
    end

    describe "password_required?" do
      it { should respond_to :password_required? }
      it { @user = create :user
           @user.password_required?.should be_false }
      it { @authentication = create :authentication
           @authentication.user.password_required?.should be_false }
    end

    describe "update_with_password" do
      it { should respond_to :update_with_password }
      # TODO: Add specs
    end
  end
end