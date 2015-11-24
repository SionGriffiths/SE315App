json.array!(@wines) do |wine|
  json.extract! wine, :id
  json.url wine_url(wine, format: :json)
end
