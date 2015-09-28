feature 'Sign Up', :devise do
  scenario 'visitor can sign up with valid email address and password' do
    sign_up_with('test@example.com', 'Test User', 'password123', 'password123')
    txts = [I18n.t( 'devise.registrations.signed_up'), I18n.t( 'devise.registrations.signed_up_but_unconfirmed')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end

  scenario 'visitor cannot sign up with invalid email address' do
    sign_up_with('test', 'Test User', 'password123', 'password123')
    expect(page).to have_content 'Email is invalid'
  end

  scenario 'visitor cannot sign up without username' do
    sign_up_with('test@example.com', '', 'password123', 'password123')
    expect(page).to have_content "Username can't be blank"
  end
end
