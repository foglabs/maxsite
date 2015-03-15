class ComicsController < ApplicationController

	def index
		@comic = Comic.last
		@news = Newsie.last(10)
	end

end