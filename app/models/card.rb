class Card < ActiveRecord::Base
  attr_accessible :estimate,:comments
  belongs_to :user
  belongs_to :card
  validates_uniqueness_of :number
  has_many :estimation_details
end
