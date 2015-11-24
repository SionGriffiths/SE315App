json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id, :base_rest_url, :name
  json.url supplier_url(supplier, format: :json)
end
