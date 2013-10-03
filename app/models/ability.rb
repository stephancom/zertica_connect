class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new # guest user (not logged in)

        unless user.new_record?
            if user.kind_of? Admin
                # admins can do this stuff
                can :manage, [User, Project, Message, Asset, ProjectFile]
                can [:index, :show, :edit, :update], Order
                can :estimate, Order, state: 'submitted'
                can :manage, ActiveChat, admin_id: user.id
                can :pay, Order, state: 'estimated'
                can :complete, Order, state: 'production'
                can :ship, Order, state: 'completed'
                cannot :destroy, Admin, id: user.id
            else
                # clients can do this stuff
                can [:show, :update], User, id: user.id  # user can always see their own account
                can :manage, [Project, Message], user_id: user.id
                can :manage, [Asset, ProjectFile], :project => { :user_id => user.id }
                can [:index, :show, :new, :create], Order, project: {user_id: user.id }
                can :pay, Order, project: {user_id: user.id }, state: 'estimated'
                # TODO
                # cannot [:edit, :update, :destroy], Order, state: (Order.available_states - ['submitted'])
                # TODO cannot destroy asset when attached to active order?
            end
        end

        cannot [:edit, :update], Order, state: 'archived'
    end
end
