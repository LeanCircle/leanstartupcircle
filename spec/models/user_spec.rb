require "spec_helper"

describe User do
  before(:each) do
    User.any_instance.stubs(:geocode).returns([1,1])
  end

  describe "associations" do
    it { should have_many :authentications }
    it { should have_many :groups }
  end

  describe "validations" do
    it { should validate_uniqueness_of :email }
    it { @user = build :user, :email => nil
         @user.should be_valid }
    it { @user1 = create :user, :email => "test@test.com"
         @user2 = build :user, :email => "test@test.com"
         @user2.should_not be_valid }
    it { @user1 = create :user, :email => "test@test.com"
         @user2 = build :user, :email => "TEST@test.com"
         @user2.should_not be_valid }
  end

  describe "attributes" do
    it { should respond_to :slug }
    it { should respond_to :role }
    it { should respond_to :name }
    it { should respond_to :email }
    it { should respond_to :phone }

    # Devise fields
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

    # Geolocation
    it { should respond_to :city }
    it { should respond_to :province }
    it { should respond_to :country }
    it { should respond_to :zip_code }
    it { should respond_to :latitude }
    it { should respond_to :longitude }
    it { should respond_to :gmaps }

    # Timestamps
    it { should respond_to :created_at }
    it { should respond_to :updated_at }
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

  describe "methods" do
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
  end
end