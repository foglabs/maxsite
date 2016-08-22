class Addstorylines < ActiveRecord::Migration
  def change
    create_table :arcs do |t|
      t.string :title
      t.timestamps
    end

    add_column :arcs, :arc_position, :integer
  end
end
