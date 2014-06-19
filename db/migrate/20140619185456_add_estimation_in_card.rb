class AddEstimationInCard < ActiveRecord::Migration
  def up
    add_column :cards, :estimation, :string	 
  end
end
