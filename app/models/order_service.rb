class OrderService

  def self.marshal_order_json order

    order.basket.line_items.each do |basket_item|
      puts '>>>>>>>>>>>>>>>>>'
      puts basket_item.wine.name
      puts basket_item.quantity
      puts basket_item.wine.product_number
      puts '>>>>>>>>>>>>>>>>>'
    end

  end

  def split_order order

  end

end