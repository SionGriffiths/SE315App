json.array!(@wines) do |wine|
  json.extract! wine, :id, :name, :description, :short_description, :country_of_origin, :grape_type, :vegetarian, :price, :supplier_company, :pic_url
  json.url wine_url(wine, format: :json)
end
