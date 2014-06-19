class AddTypeInCard < ActiveRecord::Migration
  def change
    add_column :cards, :card_type, :string
    add_column :cards, :mingle_id, :string
  end
end
