class OrderService

  def self.marshal_order_json order
    marshalled_order = Hash.new

    order.basket.line_items.each do |basket_item|
      supplier = basket_item.wine.supplier.name
      unless marshalled_order.has_key? supplier
        marshalled_order[supplier] = {}
        marshalled_order[supplier]['orderDetails'] = []
      end
      unless marshalled_order.has_key? 'customer'
        marshalled_order[supplier]['customer'] =  {'name' => order.name,
                                                  'email' => order.email,
                                                  'address' => order.address}
      end
      marshalled_order[supplier]['orderDetails'].push(
          'wineName' =>  basket_item.wine.name,
          'quantity' => basket_item.quantity,
          'productNumber' => basket_item.wine.product_number
      )

    end

    marshalled_order
  end
end