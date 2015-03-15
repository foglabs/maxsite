class Tag < ActiveRecord::Base
	has_many :comics, through: :comic_tags

end