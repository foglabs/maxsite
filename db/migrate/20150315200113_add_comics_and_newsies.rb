class AddComicsAndNewsies < ActiveRecord::Migration
	  def change
	    create_table :newsies do |t|
	      t.string :title
	      t.string :body
	      t.timestamps
	    end

 			create_table :comics do |t|
	      t.string :title
	      t.string :desc
	      t.string :img
	      t.timestamps
	    end

	    create_table :comic_tags do |t|
	    	t.integer :comic_id
	    	t.integer :tag_id
	    end

	    create_table :tags do |t|
	    	t.string :word
	    end
	  end
	end