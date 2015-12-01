class OrderService

  def self.marshal_order_json order

    marshalled_order = Hash.new
    marshalled_order['customer'] = []
    marshalled_order['customer'].push(
       'first_name' => 'test fname',
       'second_name' => 'test sname',
        'address' => 'address meight'
    )
    marshalled_order['wines'] = []
    order.basket.line_items.each do |basket_item|
      marshalled_order['wines'].push(
          'name' =>  basket_item.wine.name,
          'quantity' =>  basket_item.quantity,
          'product_number' => basket_item.wine.product_number
      )
      # puts '>>>>>>>>>>>>>>>>>'
      # puts basket_item.wine.name
      # puts basket_item.quantity
      # puts basket_item.wine.product_number
      # puts '>>>>>>>>>>>>>>>>>'
    end

    marshalled_order
  end

  def split_order order

  end

end