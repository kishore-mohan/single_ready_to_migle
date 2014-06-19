class AddCommentsToEstimationDetails < ActiveRecord::Migration
  def change
    add_column :estimation_details, :comments, :text
  end
end
