class Card < ActiveRecord::Base
  attr_accessible :estimate,:comments
  belongs_to :user
  validates_uniqueness_of :number
  validates_presence_of :estimate
  has_many :estimation_details
end
