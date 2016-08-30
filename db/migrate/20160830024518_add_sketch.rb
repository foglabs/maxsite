class AddSketch < ActiveRecord::Migration
  def change
    create_table :sketch do |t|
      t.text :info
      t.boolean :working, default: false
      t.timestamps
    end
  end
end
