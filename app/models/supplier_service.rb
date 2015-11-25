class SupplierService



  def self.update_wines



    puts "arrived in service"
    json = JSON.parse(RestClient.get "http://localhost:8080/wine/all")
     puts json
    json.each do |item|
      #check for existing prior

      new_wine = Wine.new
      new_wine.name = item['name']
      new_wine.country_of_origin = item['countryOfOrigin']
      new_wine.price = item['price']
      new_wine.short_description = item['shortDescription']
      new_wine.description = item['longDescription']
      new_wine.grape_type = item['grapeType']
      new_wine.vegetarian = item['vegetarian']
      new_wine.supplier_company = item['supplierName'] #change to supplier.name when you're not a retard


      #Similar to if not null...
      unless Wine.find_by_name item['name']
        new_wine.save
      # else
      #   old_wine = Wine.find_by_name item['name']
      #   if new_wine.price < old_wine.price
      #
      #   end
      end

    end
  end






end