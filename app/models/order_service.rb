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
end