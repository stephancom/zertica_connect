class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new # guest user (not logged in)

        unless user.new_record?
            if user.kind_of? Admin
                # admins can do this stuff
                can :manage, [User, Project, Message, ProjectFile]
                can [:index, :new, :create, :show, :edit, :update], Order
                can :estimate, Order, state: 'submitted'
                can :manage, ActiveChat, admin_id: user.id
                can :pay, Order, state: 'estimated'
                can :complete, Order, state: 'production'
                can :ship, Order, state: 'completed'
                can :archive, Order, state: 'shipped'
                cannot :destroy, Admin, id: user.id
            else
                # clients can do this stuff
                can [:show, :update], User, id: user.id  # user can always see their own account
                can :manage, [Project, Message], user_id: user.id
                can :manage, ProjectFile, :project => { :user_id => user.id }
                can [:index, :show, :new, :create, :update], Order, project: {user_id: user.id }
                can :pay, Order, project: {user_id: user.id }, state: 'estimated'
                # TODO
                # cannot [:edit, :update, :destroy], Order, state: (Order.available_states - ['submitted'])
                can :ring, :bell
            end
        end

        cannot [:edit, :update], Order, state: 'archived'
        cannot :destroy, ProjectFile do |file|
            file.orders.any? or file.shipped_orders.any?
        end
    end
end
