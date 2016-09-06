class Addenabledtoarcs < ActiveRecord::Migration
  def change
    add_column :arcs, :enabled, :boolean
  end
end
