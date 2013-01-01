require "spec_helper"
require "cancan/matchers"

describe User do
  subject { Ability.new(user) }
  let(:group) { create :group }
  let(:self_group) { create :group, :user_id => user.id }

  describe "anonymous browser" do
    let(:user) { User.new(:role => nil) }

    it { should_not be_able_to(:manage, :admin) }
    it { should_not be_able_to(:update, group) }
    it { should_not be_able_to(:update, self_group) }
  end

  describe "member" do
    let(:user) { create :user, :role => "member" }

    it { should_not be_able_to(:manage, :admin) }
    it { should_not be_able_to(:update, group) }
    it { should be_able_to(:update, self_group) }
  end

  describe "admin" do
    let(:user) { create :user, :role => "admin" }

    it { should be_able_to(:manage, :all) }
  end
end