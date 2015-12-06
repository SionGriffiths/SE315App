class SupplierService

  # This class is a service used to update the wines in the system from the supplier webservices
  # This class is invoked on a timed schedule only with no direct calls from the rest of the application
  # The cron timings are defined in config/initializers/task_schedulers.rb

  # This service class will periodically poll the supplier webservices for updates
  # and update wines if they are more recently modified than the last successful update time
  # currently the updating of previously help wines is done solely if the new version is
  # cheaper than the previous

  # Initialize time to 1970, this is used as the first last update time
  # we want everything at first
  @time = Time.new(1970)


  def self.update_wines suppliers

    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    puts '>>>>>>      Update Supplier'
    puts '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

    suppliers.each do |supplier|
      result = '[]'
      begin
        # make get request for wines to suppliers with @time as if-modified-since header value
        # we'll only receive wines that are updated since then
        result = RestClient::Request.execute(
            :method => :get,
            :url => supplier.base_rest_url+supplier.all_wines_url,
            :headers => {"If-Modified-Since" => @time}
        )
      rescue Errno::ECONNREFUSED
        next #go to next supplier if connection problem
      end
      if result.length < 1
        next # nothing new  skip, no need to parse
      else
        @time = Time.now  # Set last update time to now
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

  # selectively populate a wine instance from the json
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