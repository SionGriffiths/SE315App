Given(/^we have the following Wines:$/) do |wines|
  wines_attributes = wines.hashes.map { |tab_wine_attrs|
    wine_attrs = FactoryGirl.attributes_for(:wine).stringify_keys
    wine_attrs.merge(tab_wine_attrs)
  }
  Wine.create!(wines_attributes)
end

When(/^I search for Wine "(.*?)"$/) do |query|
  visit('/wines')
  fill_in('search', with: query)
  click_button('wine-search-submit')
end

Then(/^the results must be:$/) do |expected_results|
  results = [['name','short_description','price']] +
      page.all('tr.wine').map {|tr|
        [ tr.find('.name').text,
          tr.find('.short_desc').text,
          tr.find('.price').text ]
      }
  expected_results.diff!(results)

end