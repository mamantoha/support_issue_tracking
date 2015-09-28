class TicketPolicy
  attr_reader :user, :ticket

  def initialize(user, ticket)
    @user = user
    @ticket = ticket
  end

  def index?
    user && (user.admin? || user.manager?)
  end

  def edit?
    user && (user.admin? || user.manager?)
  end

  def destroy?
    user && user.admin?
  end

  def assign_to_me?
    user
  end

end
