class Comic < ActiveRecord::Base
	has_many :tags, through: :comic_tags
end