class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin #Admins
      can :manage, :all
    elsif user.new_record? #Existing Users
      can [:edit, :update], User, id: user.id
    else #Guest User
      can :create, :User
    end
  end
end
