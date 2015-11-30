class Basket < ActiveRecord::Base

  #This class is based off the examples in the course textbook - Agile Web Development with Rails

  has_many :line_items, dependent: :destroy


  def add_wine(wine_id, quantity)
    if quantity < 1
      quantity = 1
    end
    current_item = line_items.find_by(wine_id: wine_id)
    if current_item
      current_item.quantity += quantity
    else
      current_item = line_items.build(wine_id: wine_id)
      current_item.quantity = quantity
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_items
    line_items.to_a.sum { |item| item.quantity}
  end

end
