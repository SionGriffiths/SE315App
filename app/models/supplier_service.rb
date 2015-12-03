class SupplierService

#TODO class might make more sense as a module.. ??    Needs a major refactor and rethink anyhow

  def self.update_wines suppliers
    suppliers.each do |supplier|

      result = '[]'
      begin
       RestClient.get supplier.base_rest_url+supplier.all_wines_url
       rescue Errno::ECONNREFUSED
        return
      end
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
  end



  private

  #TODO Move this somewhere sensible maybe?
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