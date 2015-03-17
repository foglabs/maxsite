class AddOrder < ActiveRecord::Migration
  
  def up
  	add_column :comics, :position, :integer
  end

  def down
  	remove_column :comics, :position
  end
end
