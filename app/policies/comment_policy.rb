class CommentPolicy
  attr_reader :user, :ticket

  def initialize(user, ticket)
    @user = user
    @ticket = ticket
  end

  def new?
    # user && user.admin?
    true
  end

end
