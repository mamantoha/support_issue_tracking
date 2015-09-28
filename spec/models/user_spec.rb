describe User do
  before(:each) { @user = User.new(email: 'admin@example.com') }

  subject { @user }

  it "#email returns a string" do
    expect(@user.email).to match 'admin@example.com'
  end
end
