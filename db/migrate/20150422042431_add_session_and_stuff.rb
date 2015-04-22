class AddSessionAndStuff < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :code
      t.timestamps
    end
  end
end
