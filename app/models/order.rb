class Order < ActiveRecord::Base
  belongs_to :basket
  validates :name, :address, :email, presence: true
  validates_format_of :email,
                      with: /\A([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                      message: 'Bad email address format'
  validates_format_of :name,
                      with: /\A([a-zA-Z0-9'\s]*{2,})\z/i,
                      message: 'Bad name format'
end
