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




  # def split_order order
  #
  # end
  #
  #
  # def self.suppliers_in_order order
  #   supplier_list =[]
  #   order.basket.line_items.each do |basket_item|
  #     if !supplier_list.include? basket_item.wine.supplier
  #       supplier_list.push basket_item.wine.supplier
  #     end
  #   end
  #   supplier_list
  # end
  #
  # def create_orders_for_suppliers
  #
  # end

end