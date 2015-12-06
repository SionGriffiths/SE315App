class OrderService

  # Order service is a PORO used to marshal order information into a
  # single hash object in order to facilitate POSTing to a webservice

  def self.marshal_order_to_hash order

    marshalled_order = Hash.new

    order.line_items.each do |item|
      supplier = item.wine.supplier.name

      # Each supplier has a separate top level entry, used to split the order
      unless marshalled_order.has_key? supplier
        marshalled_order[supplier] = {}
        marshalled_order[supplier]['orderDetails'] = []
      end

      # Customer has a top level entry since they're unique across the order
      unless marshalled_order.has_key? 'customer'
        marshalled_order[supplier]['customer'] =  {'name' => order.name,
                                                   'email' => order.email,
                                                   'address' => order.address}
      end

      # Add the details for each wine in the basket to the hash
      marshalled_order[supplier]['orderDetails'].push(
          'wineName' =>  item.wine.name,
          'quantity' => item.quantity,
          'productNumber' => item.wine.product_number
      )

    end
    marshalled_order
  end


  #Prepare and send order to webservice
  def self.do_order order
    send_data = marshal_order_to_hash order
    suppliers = Supplier.all
    suppliers.each do |supplier|
      # The order hash is split on suppliers at the top level
      if send_data[supplier.name]
        #we prepare each supplier their part as json
        send_json = send_data[supplier.name].to_json
        begin #Post the marshalled order as json to each supplier web service
          RestClient.post(supplier.base_rest_url + supplier.new_orders_url, send_json,
                          :content_type => :json, :accept => :json )
        rescue Errno::ECONNREFUSED
          redirect_to root_path, notice: 'Cannot place order currently, try again later'
          return
        end
      end
    end
  end



end