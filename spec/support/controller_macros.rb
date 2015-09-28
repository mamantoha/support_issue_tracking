module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:user, :admin)
    end
  end

  def login_manager
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:manager]
      sign_in FactoryGirl.create(:user, :manager)
    end
  end

end
