class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(:role => nil) # guest user (not logged in)
    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'member'
      can :update, Group, :user_id => user.id
      can :create, Group
    else
      can :read, Group
      can :read, User
    end
  end

end