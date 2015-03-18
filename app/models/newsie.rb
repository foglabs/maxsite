class Newsie < ActiveRecord::Base

	def format_time
		created_at.strftime('%b-%d-%Y')
	end
end