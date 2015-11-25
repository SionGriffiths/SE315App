# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Supplier.create(name: "Drink AND Drive!", base_rest_url: "http://localhost:8080")
Supplier.create(name: "Alcohol Destroyed My Family", base_rest_url: "http://localhost:8090")