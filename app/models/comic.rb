class Comic < ActiveRecord::Base
	has_many :tags, through: :comic_tags
	validates :position, uniqueness: true

	def nextcom
		# c = Comic.where( position: self.position + 1 ).first.try(:id)
		# c ? c : Comic.last.id

		c = nil
		trying = self.position + 1

		# in case the order is fucked up
		unless c
			c = Comic.where( position: trying ).first.try(:id)
			trying += 1
		else
			c = Comic.last
		end

		c
	end

	def lastcom
		# c = Comic.where( position: self.position - 1 ).first.try(:id)
		# c ? c : Comic.last.id

		c = nil
		trying = self.position - 1

		# in case the order is fucked up
		unless c || trying < 1
			c = Comic.where( position: trying ).first.try(:id)
			trying -= 1
		end

		if trying < 1
			c = Comic.last
		end
		
		c
	end
end