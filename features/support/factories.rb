require 'factory_girl'

FactoryGirl.define do

  factory :supplier do |f|
    f.base_rest_url 'test Url'
    f.all_wines_url 'wines url'
    f.new_orders_url 'orders url'
    f.name 'supplier_name'
  end

  factory :wine do |f|
    f.name 'test_wine_name'
    f.description 'test_long_description'
    f.short_description 'test_short_desc'
    f.country_of_origin 'test_country'
    f.grape_type 'test_grape'
    f.vegetarian false
    f.price 9.99
    f.pic_url 'test_picurl'
    f.supplier Supplier.find_or_create_by name: 'supplier_name'
  end


end