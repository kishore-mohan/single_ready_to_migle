class Card < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  validates_uniqueness_of :number, :scope => :user_id
end
