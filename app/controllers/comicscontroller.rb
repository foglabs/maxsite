class ComicsController < ApplicationController

	def index
		@comic = Comic.last
	end

end