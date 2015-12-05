
Given(/^we have the following Wines:$/) do |wines|
  wines_attributes = wines.hashes.map { |tab_wine_attrs|
    wine_attrs = FactoryGirl.attributes_for(:wine).stringify_keys
    wine_attrs.merge(tab_wine_attrs)
  }
  Wine.create!(wines_attributes)
end


When(/^I am on the wines listing page$/) do
  visit("/wines")
end


When(/^I click on the image for "(.*?)"$/) do |wine_name|
  node = page.find("//*[@id='#{wine_name}']/td[6]/a")
  node.click

end


Then(/^I can view details for that wine:$/) do |expected_results|
  results = [['name','short_description','price']] +
      page.all('dl.dl-horizontal').map {|dd|
        [ dd.find('.show_wine_name').text,
          dd.find('.show_wine_short_desc').text,
          dd.find('.show_wine_price').text ]
      }
  expected_results.diff!(results)

end

When(/^I remove "(.*?)" from my basket$/) do |wine_name|
  node = page.find("//*[@id='remove_#{wine_name}']")
  node.click
end

Then (/^My basket should be empty$/) do
  expect(page).to have_text('Number of items : 0')
  expect(page).to have_text('Your basket is empty')
end

Then(/^I can see the following (.+) detailed in the page$/) do |field_name|
  expect(page).to have_text(field_name)
end

When(/^I add (\d+) of that wine to my basket$/) do |quantity|
  fill_in('quantity', with: quantity)
  click_button('Add to basket')
end

Then(/^I should have (\d+) of "(.*?)" in my basket$/) do |quantity, wine_name|
  row = page.find("tr##{wine_name}")
  expect(row).to have_text(quantity)
  expect(row).to have_text(wine_name)
end
