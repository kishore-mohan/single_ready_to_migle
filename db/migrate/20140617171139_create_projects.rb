class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :mingle_name

      t.timestamps
    end
  end
end
