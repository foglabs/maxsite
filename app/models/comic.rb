class Comic < ActiveRecord::Base
	has_many :comments
	has_many :tags, through: :comic_tags
	validates :position, uniqueness: true

	def nextcom
		first = Comic.where('position > ?', position).try(:first)
	end

	def lastcom
		last = Comic.where('position < ?', position).try(:last)
	end
end