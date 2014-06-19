class User < ActiveRecord::Base
  attr_accessible :is_admin, :password
  has_many :estimation_details
  has_many :cards
  has_many :sessions, dependent: :destroy
  # before_save :encrypt_password



end
