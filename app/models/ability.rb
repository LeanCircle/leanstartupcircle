class Ability
  include CanCan::Ability

  def initialize(user)
   user ||= User.new(:role => nil) # guest user (not logged in)
   if user.role == 'admin'
     can :manage, :all
   elsif user.role == 'member'
      can :create, Meetup
      can :update, Meetup, :organizer_id => user.authentications.find_by_provider('meetup').try(:uid)
   else
     can :read, Meetup
     can :read, User
   end
  end

end
