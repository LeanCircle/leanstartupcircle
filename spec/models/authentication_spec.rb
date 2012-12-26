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
        it { @group = create :group, :organizer_id => "12345"
             @authentication = create :authentication, :provider => "twitter", :uid => "12345"
             @authentication.groups.should_not include(@group) }
      end
    end
  end

  describe "validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :provider }

    describe "uniqueness of uid" do
      it { should validate_uniqueness_of :uid }
      describe "uniqueness of uid scoped to provider" do
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

  describe "default values" do
    # Just a stub
  end

  describe "scopes" do
    # Just a stub
  end

  describe "methods" do
    # Just a stub
  end
end