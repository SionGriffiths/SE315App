class LineItem < ActiveRecord::Base
  belongs_to :wine
  belongs_to :basket
end
