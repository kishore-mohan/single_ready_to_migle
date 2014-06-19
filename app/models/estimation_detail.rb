class EstimationDetail < ActiveRecord::Base
  attr_accessible :estimate, :comments
  belongs_to :card
  belongs_to :user

  validates_presence_of :estimate
end
