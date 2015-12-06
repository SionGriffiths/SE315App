
And(/^I have added "(.*?)" to my basket$/)do |wine_name|
  visit("/wines")
  node = page.find("//*[@id='#{wine_name}']/td[6]/a")
  node.click
  click_button('Add to basket')
  expect(page).to have_link('go_checkout')
end


When(/^I attempt to checkout$/) do
  click_link('go_checkout')
end

Then(/^I should be prompted to log in$/)do
  current_path == '/login'
end

Given(/^I am logged in$/)do
  visit("/login")
  fill_in('login_email_field', with: 'factory@test.user')
  fill_in('login_password_field', with: 'secret')
  click_button('login_submit')
end

Then(/^I should be able to place an order$/)do
   puts current_url
   click_button('place_order')
   expect(page).to have_text('Order was successfully created.')
    puts current_url

end