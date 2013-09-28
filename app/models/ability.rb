class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new # guest user (not logged in)

        if user.kind_of? Admin
            can :manage, [User, Project, Message, Asset]
            can :manage, ActiveChat, admin_id: user.id
            cannot :destroy, Admin, id: user.id
        end

        # any logged in user can
        unless user.new_record?
            can [:show, :update], User, id: user.id  # user can always see their own account
            can :manage, [Project, Message], user_id: user.id
            can :manage, Asset, :project => { :user_id => user.id }
        end
        can :manage, Asset #, project: { user_id: user.id }
    end
end
