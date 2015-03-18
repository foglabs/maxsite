class Comic < ActiveRecord::Base
	has_many :tags, through: :comic_tags
	validates :position, uniqueness: true

	def nextcom
		c = Comic.where( position: self.position + 1 ).first.try(:id)
		c ? c : Comic.last.id
	end

	def lastcom
		c = Comic.where( position: self.position - 1 ).first.try(:id)
		c ? c : Comic.last.id
	end
end