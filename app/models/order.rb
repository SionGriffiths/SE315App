class Order < ActiveRecord::Base

  #Order is a simple Activerecord class used to wrap user and basket information
  #Validations based off examples given in workshops
  belongs_to :basket
  validates :name, :address, :email, presence: true
  validates_format_of :email,
                      with: /\A([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                      message: 'Bad email address format'
  validates_format_of :name,
                      with: /\A([a-zA-Z0-9'\s]*{2,})\z/i,
                      message: 'Bad name format'
end
