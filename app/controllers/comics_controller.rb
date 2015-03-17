class ComicsController < ApplicationController

	def index
		@comic = Comic.last
		@news = Newsie.last(10)
	end

	def show
		# change to give appropriate news from displayed comic
		@news = Newsie.last(10)

		@comic = Comic.find(params[:id])
	end

	def create
		Comic.create(comic_params)
	end

	private
		def comic_params
			params.require(:comic).permit(:title, :desc, :img)
		end
end