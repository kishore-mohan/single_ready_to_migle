class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :number
      t.text :description
      t.text :ur
      t.integer :user_id
      t.integer :estimate
      t.text :comments
      t.timestamps
    end
  end
end
