class Supplier < ActiveRecord::Base

  #Used to represent a supplier web service

  has_many :wine, dependent: :destroy
end
