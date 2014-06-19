class CreateEstimationDetails < ActiveRecord::Migration
  def change
    create_table :estimation_details do |t|
      t.integer :user_id
      t.integer :estimate
      t.integer :number
      t.integer :card_id
      t.timestamps
    end
  end
end
