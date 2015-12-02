class Order < ActiveRecord::Base
  belongs_to :basket
  belongs_to :user
  # has_many :line_items, dependent: :destroy

  # validates :name, :address, presence: true

end
