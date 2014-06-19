class Card < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :card
  validates_uniqueness_of :number
end
