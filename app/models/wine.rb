class Wine < ActiveRecord::Base

  has_many :line_items
  belongs_to :supplier

  # List of attributes we want to search on
  @search_attribs = %w(name description short_description country_of_origin grape_type bottle_size vegetarian product_number price)

  before_destroy :ensure_not_referenced_by_any_line_item

  #we don't want wines to be created without a supplier
  validates :supplier, presence: true


  #base comparison for price
  def more_expensive_than?(other_price)
    Float(self.price) > Float(other_price)
  end

  # Pagination as discussed in SE315 lectures and workshops
  def self.per_page
    6
  end


  # CSA example and http://stackoverflow.com/questions/24805784/rails-4-sanitizing-user-input
  def self.search(search_string)
    columns = @search_attribs
    terms = search_string.split

    query = terms.map do |term|
      fields = columns.map do|column|
        "LOWER(#{column}) LIKE #{sanitize("%#{term}%")}"
      end
      "(#{fields.join(' OR ')})"
    end.join(' and ')
    Wine.where(query)
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
