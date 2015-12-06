Given(/^I am not logged in$/) do
  visit('/logout')
end

Given(/^I have a valid user account$/)do
 @user = User.create! FactoryGirl.attributes_for(:user).stringify_keys
end

When(/^I try to log into the site with valid credentials$/) do
  visit("/login")
  fill_in('login_email_field', with: @user.email)
  fill_in('login_password_field', with: @user.password)
  click_button('login_submit')
end

Then(/^I should successfully log in$/) do
  expect(page).to have_link('logout_button')
  expect(page).to have_text('LOGGED IN')
end

When(/^I try to log into the site with invalid credentials$/) do
  visit("/login")
  fill_in('email', with: 'invalid@aber.ac.uk')
  fill_in('password', with: 'secret')
  click_button('login_submit')
end

Then(/^I should be prompted to log in again$/) do
  expect(page).to have_xpath("//*[@id='login_submit']")
  expect(current_path) == '/login'
end

When(/^I go to the register page$/) do
  visit("/register")
end
And(/^I fill in and submit the registration form$/) do
  fill_in('user_name', with: 'new user')
  fill_in('user_address', with: 'new user address')
  fill_in('user_email', with: 'newUser@sig2.com')
  fill_in('user_password', with: 'secret')
  fill_in('user_password_confirmation', with: 'secret')
  click_button('register_submit')
end
Then(/^I should be logged in as the new user$/) do
 expect(page).to have_text('Thank you for registering!')
 expect(page).to have_text('Hi, new user')
 expect(page).to have_xpath("//*[@id='logout_button']")
end

And(/^I attempt to log out$/)do
  visit("/logout")
end

Then(/^I should be logged out$/)do
  expect(page).to have_xpath("//*[@id='login_button']")
  expect(page).to have_text('Not logged in')
end