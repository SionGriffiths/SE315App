class Order < ActiveRecord::Base
  belongs_to :basket
  belongs_to :user


end
