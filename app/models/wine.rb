class Wine < ActiveRecord::Base

  def more_expensive_than?(other_price)
   Float(self.price) > Float(other_price)
  end

end
