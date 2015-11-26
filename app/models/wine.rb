class Wine < ActiveRecord::Base

  has_many :line_items
  belongs_to :supplier

  before_destroy :ensure_not_referenced_by_any_line_item

  #we don't want wines to be persisted without a supplier
  validates :supplier, presence: true


  #base comparison
  def more_expensive_than?(other_price)
   Float(self.price) > Float(other_price)
  end

  # Pagination as discussed in SE315 lectures and workshops
  def self.per_page
    6
  end


  private

  #This method is based off the examples in the course textbook - Agile Web Development with Rails
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, 'Line Items present')
    end
  end

end
