class TicketPolicy
  attr_reader :user, :ticket

  def initialize(user, ticket)
    @user = user
    @ticket = ticket
  end

  def index?
    user && user.admin?
  end

  def edit?
    user && user.admin?
  end

  def destroy?
    user && user.admin?
  end

end
