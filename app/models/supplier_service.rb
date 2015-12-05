class SupplierService

#TODO class might make more sense as a module.. ??    Needs a major refactor and rethink anyhow
  @time = Time.new(1970)


  def self.update_wines suppliers
puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
puts '>>>>>>      Update Supplier'
puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

    suppliers.each do |supplier|
      result = '[]'
      begin
        result = RestClient::Request.execute(
            :method => :get,
            :url => supplier.base_rest_url+supplier.all_wines_url,
            :headers => {"If-Modified-Since" => @time}
        )
      rescue Errno::ECONNREFUSED
        next #go to next supplier if connection problem
      end
      if result.length < 1
        next # nothing new so no need to parse

      else
        @time = Time.now
        process_result(result,supplier)
      end
    end
  end




  private

  def self.process_result (result, supplier)
    json = JSON.parse(result)

    json.each do |item|
      #check for existing prior
      wine = Wine.find_by(product_number: item['productNumber'])

      #if wine is currently not saved in db, create and save
      if  !wine
        new_wine = Wine.new
        set_wine_attibs_from_JSON(item, new_wine, supplier)
        new_wine.save #do we want to raise error here? probably
      else
        #compare prices
        #if new is cheaper, update the record with new details
        if wine.more_expensive_than? item['price']
          set_wine_attibs_from_JSON(item, wine, supplier)
          wine.save
        end
      end
    end
  end

  #TODO Move this somewhere sensible maybe? Do it more elegantly :(
  # populate a wine instance from the json
  def self.set_wine_attibs_from_JSON(json, wine, supplier)
    wine.name = json['name']
    wine.country_of_origin = json['countryOfOrigin']
    wine.price = json['price']
    wine.short_description = json['shortDescription']
    wine.description = json['longDescription']
    wine.grape_type = json['grapeType']
    wine.vegetarian = json['vegetarian']
    wine.product_number = json['productNumber']
    wine.pic_url = json['pictureURL']
    wine.bottle_size = json['bottleSize']
    wine.supplier_id = supplier.id
  end


end