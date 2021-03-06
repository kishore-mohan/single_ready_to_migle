class Card < ActiveRecord::Base
  attr_accessible :estimate,:comments
  belongs_to :user
  belongs_to :card
  belongs_to :project

  validates_uniqueness_of :number, :scope => :project_id

  has_many :estimation_details
end
