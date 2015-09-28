require 'rails_helper'

describe UsersController do
  login_admin

  it 'should have a current user' do
    subject.current_user.should_not be_nil
  end

  it "should get index" do
    get 'index'
    response.should be_success
  end

end
