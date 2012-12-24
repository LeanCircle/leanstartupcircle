require 'spec_helper'

describe Group do

  #let(:group)  { Factory.create(:group) }

  describe "associations" do
    it "can be instantiated" do
        Group.new.should be_an_instance_of(Group)
      end
    #it { should belong_to :authentication }
    #it { should helong_to :user }
  end

  describe "validations" do
    #it { @group = Factory :group
    #     should validate_uniqueness_of :name, :meetup_id, :meetup_link }
    #it { should validate_presence_of :name }
    #it { should ensure_length_of(:content).is_at_most(130) }
  end

end