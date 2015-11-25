class Wine < ActiveRecord::Base

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item


  def more_expensive_than?(other_price)
   Float(self.price) > Float(other_price)
  end

  def self.per_page
    6
  end


  private

  #This method is based off the examples in the course textbook - Agile Web Development with Rails
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
    end
  end

end
