class AddEnabled < ActiveRecord::Migration
  def change
    add_column :comics, :enabled, :boolean

  end
end
