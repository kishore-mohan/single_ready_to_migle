class AddProjectidInCard < ActiveRecord::Migration
def change
  add_column :cards, :project_id, :integer
end
end
