Given(/^I am not logged in$/) do
  visit('/logout')
end

When(/^I try to log into the site with valid credentials$/) do
  visit("/login")
  fill_in('email', with: 'sig1@aber.ac.uk')
  fill_in('password', with: 'secret')
  click_button('login_submit')
end

Then(/^I should successfully log in$/) do

  expect(page).to have_xpath("//*[@id='logout_button']")

end