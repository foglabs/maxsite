class Comic < ActiveRecord::Base
	has_many :tags, through: :comic_tags
	validates :position, uniqueness: true

	def nextcom
		Comic.where( position: self.position + 1 ).first.try(:id)
	end

	def lastcom
		Comic.where( position: self.position - 1 ).first.try(:id)
	end
end