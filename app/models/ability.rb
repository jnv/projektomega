class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in (current) user. For example:
    #
    #   if user
    #     can :access, :all
    #   else
    #     can :access, :home
    #     can :create, [:users, :sessions]
    #   end
    #
    # Here if there is a user he will be able to perform any action on any controller.
    # If someone is not logged in he can only access the home, users, and sessions controllers.
    #
    # The first argument to `can` is the action the user can perform. The second argument
    # is the controller name they can perform that action on. You can pass :access and :all
    # to represent any action and controller respectively. Passing an array to either of
    # these will grant permission on each item in the array.
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new(role: :guest) # guest user (not logged in)

    can :read, :all

    case user.role
      when :admin
        can :access, :all
      when :coordinator

      when :user
        character_id = user.character.try(:id)
        can :update, :characters, [:number, :name, :born, :country, :assignment, :specialisation, :portrait], :user_id => user.id
        can :update, :mission_attendances, [:report], :character_id => character_id
        #can :update, :characters, [:name]
        can [:create, :update], :evaluations, author_id: character_id
        cannot :create, :evaluations, :author
      when :banned

      else
        #TODO: Report exception
    end

    if user.role == :admin

    elsif user.role == :coordinator


    end

  end
end
