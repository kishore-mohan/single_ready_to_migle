class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_id
      t.string :avatar
      t.string :name
      t.boolean :is_admin
      t.integer :project_id

      t.timestamps
    end
  end
end
