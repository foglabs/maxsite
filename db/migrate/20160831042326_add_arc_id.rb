class AddArcId < ActiveRecord::Migration
  def change
    add_column :comics, :arc_id, :integer
  end
end
