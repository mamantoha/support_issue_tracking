describe DepartmentPolicy do
  subject { DepartmentPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it "denies access if not an admin" do
      expect(DepartmentPolicy).not_to permit(current_user)
    end
    it "allows access for an admin" do
      expect(DepartmentPolicy).to permit(admin)
    end
  end
end
