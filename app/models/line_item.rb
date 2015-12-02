class LineItem < ActiveRecord::Base
  belongs_to :wine
  belongs_to :basket
  # belongs_to :order

  def total_price
    wine.price * quantity
  end


end
