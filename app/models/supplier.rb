class Supplier < ActiveRecord::Base
  #TODO should belong to wines with  'belongs_to :wine'
  #todo or if the has_many :wine is here we can have dependand destroy?
  has_many :wine, dependent: :destroy
end
