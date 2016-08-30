class AddSketch < ActiveRecord::Migration
  def change
    create_table :sketches do |t|
      t.text :info
      t.boolean :working, default: false
      t.timestamps
    end
  end
end
