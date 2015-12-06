class LineItem < ActiveRecord::Base
  belongs_to :wine
  belongs_to :basket
  belongs_to :order

  #Simple class to represent an entry in a basket, based off the examples in the suggested course textbook
  #- Agile Web Development with Rails
  def total_price
    wine.price * quantity
  end


end
