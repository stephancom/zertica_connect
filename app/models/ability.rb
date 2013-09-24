class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new # guest user (not logged in)

        if user.kind_of? Admin
            can :manage, :all
            cannot :destroy, Admin, :id => user.id
        end

        # any logged in user can
        unless user.new_record?
            can [:show, :update], User, :id => user.id  # user can always see their own account
            can :manage, [Project, Message], :user_id => user.id
        end
  end
end
