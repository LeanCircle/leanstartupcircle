class Ability
  include CanCan::Ability

  def initialize(user)
   user ||= User.new # guest user (not logged in)
   if user.role == 'admin'
     can :manage, :all
   elsif user.role == 'member'
     can :manage, :all
   else
     can :read, :meetups
     can :read, :users
   end
  end

end
