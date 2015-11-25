class Basket < ActiveRecord::Base

  #This class is based off the examples in the course textbook - Agile Web Development with Rails

  has_many :line_items, dependent: :destroy


  def add_wine(wine_id)
    current_item = line_items.find_by(wine_id: wine_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(wine_id: wine_id)
    end
    puts '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
    puts current_item.quantity
    current_item
  end


end
