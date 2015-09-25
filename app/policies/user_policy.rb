class UserPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

end
