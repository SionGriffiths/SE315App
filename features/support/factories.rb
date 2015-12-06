require 'factory_girl'

FactoryGirl.define do

  factory :supplier do |f|
    f.base_rest_url 'http://localhost:8080'
    f.all_wines_url '/wine/all'
    f.new_orders_url '/order/new'
    f.name 'supplier_name'
    f.last_update '0000-00-00 00:00:00'
  end

  factory :wine do |f|
    f.name 'test_wine_name'
    f.description 'test_long_description'
    f.short_description 'test_short_desc'
    f.country_of_origin 'test_country'
    f.grape_type 'test_grape'
    f.product_number '0002'
    f.vegetarian false
    f.price 9.99
    f.pic_url 'test_picurl'
    f.supplier Supplier.create! FactoryGirl.attributes_for(:supplier).stringify_keys
  end #We'll use an actual supplier here

  factory :user do |f|
    f.name 'testname'
    f.address 'test address'
    f.email 'factory@test.user'
    f.password 'secret'
  end

end