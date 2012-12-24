require "spec_helper"

describe Authentication do

  describe "associations" do
    it { should belong_to :user }
    it { should have_many :groups }
  end

  describe "validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :provider }
    it { should validate_uniqueness_of :uid }

    it { @authentication1 = create :authentication, :provider => "twitter", :uid => "12345"
         @authentication2 = build :authentication, :provider => "twitter", :uid => "12345"
         @authentication2.should_not be_valid }
  end

  describe "attributes" do
    it { should respond_to :user_id }
    it { should respond_to :provider }
    it { should respond_to :uid }
    it { should respond_to :token }
    it { should respond_to :secret }
    it { should respond_to :image }
    it { should respond_to :url }
    it { should respond_to :name }
    it { should respond_to :location }
    it { should respond_to :description }

    # Timestamps
    it { should respond_to :created_at }
    it { should respond_to :updated_at }
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