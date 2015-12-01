class User < ActiveRecord::Base

  validates_presence_of :first_name, :second_name, :email
  validates_format_of :email,
                      with: /\A([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                      message: 'Bad email address format'
  validates_format_of :first_name, :second_name,
                      with: /\A([a-zA-Z0-9']*{2,})\z/i,
                      message: 'Bad name format'
  validates_uniqueness_of :email

  has_one :user_detail, dependent: :destroy
  accepts_nested_attributes_for :user_detail


end
