require "spec_helper"

describe ContactMessage do

  before(:each) do
    @contact_message = ContactMessage.new(:sender_name => "Bob",
                                          :sender_email => "email@address.com")
  end

  describe "validations" do
    it { should validate_presence_of :sender_name }
    it { should validate_presence_of :sender_email }
    it { should validate_presence_of :content }
    it { should ensure_length_of(:content).is_at_least(10) }
    it { @contact_message.sender_email = "@address.com"
         @contact_message.should_not be_valid }
    it { @contact_message.sender_email = "test@address.c"
         @contact_message.should_not be_valid }
  end

  describe "attributes" do
    it { should respond_to :sender_name }
    it { should respond_to :sender_email }
    it { should respond_to :content }
  end

  describe "methods" do
    it { should respond_to :sender }
    it { @contact_message.sender.include?("Bob").should be_true }
    it { @contact_message.sender.include?("email@address.com").should be_true }
    it { @contact_message.sender.should == "Bob <email@address.com>" }
  end

end