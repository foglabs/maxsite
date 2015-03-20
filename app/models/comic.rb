class Comic < ActiveRecord::Base
	has_many :tags, through: :comic_tags
	validates :position, uniqueness: true

	def nextcom
		first = Comic.where('position > ?', position).try(:first)
		first ||= Comic.first 

		# c = nil
		# trying = self.position + 1

		# # in case the order is fucked up
		# while true
		# 	c = Comic.where( position: trying )
		# 	break unless c == nil
		# 	trying += 1
		# end

		# a = c.try(:first)
		# a ||= Comic.last
		# a.id
	end

	def lastcom
		last = Comic.where('position < ?', position).try(:first)
		last ||= Comic.first 
		# c = nil
		# trying = self.position - 1

		# # in case the order is fucked up
		# while true
		# 	c = Comic.where( position: trying )
		# 	break unless c == nil
		# 	break if trying	< 1
		# 	trying -= 1
		# end

		# a = c.try(:first)
		# a ||= Comic.first
		# a.id
	end
end