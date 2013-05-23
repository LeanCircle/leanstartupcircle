class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(:role => nil) # guest user (not logged in)
    if user.role == 'admin'
      can :manage, :all
    # editor role used in Gollum wiki
    # editor can create or edit wiki pages. Only admin can delete wiki pages.
    elsif user.role == 'member' || user.role == 'editor'
      can :read, Group
      can :update, Group, :user_id => user.id
      can :create, Group
    else
      can :read, Group
      can :read, User
      can :create, Group
    end
  end

end