class DepartmentPolicy
  attr_reader :user, :department

  def initialize(user, department)
    @user = user
    @department = department
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

  def create?
    user && user.admin?
  end

end
