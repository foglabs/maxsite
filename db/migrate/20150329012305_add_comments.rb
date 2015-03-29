class AddComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :comic_id
      t.string :body
      t.string :name
      t.timestamps
    end
  end
end