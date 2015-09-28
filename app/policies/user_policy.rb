class UserPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    user && user.admin?
  end

  def edit?
    user && user.admin? && !model.admin? && !model.deleted?
  end

  def destroy?
    user && user.admin? && !model.admin? && !model.deleted?
  end

  def restore?
    user && user.admin? && !model.admin? && model.deleted?
  end

  def new?
    user && user.admin?
  end

  def create?
    user && user.admin?
  end

end
