# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Supplier.create(name: 'Drink AND Drive!', base_rest_url: 'http://localhost:8080', all_wines_url: '/wine/all', new_orders_url: '/order/new', last_update:'0000-00-00 00:00:00')
Supplier.create(name: 'Get a Grape!', base_rest_url: 'http://localhost:8090', all_wines_url: '/wine/all', new_orders_url: '/order/new', last_update:'0000-00-00 00:00:00')


User.transaction do
  1..5.times do |i|
    User.create!(name: "Name",
                 address:  "Some place lovely",
                 email:      "sig#{i}@aber.ac.uk",
                 password_digest:  BCrypt::Password.create('secret') )
  end
end



