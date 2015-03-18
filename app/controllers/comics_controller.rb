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
		@comic = Comic.create(comic_params)
		@news = Newsie.last(10)

		if @comic.save
			redirect_to comic_path(@comic)
		else
			render 'new'
		end
	end

	def new
		@news = Newsie.last(10)
		@comic = Comic.new
	end

	private
		def comic_params
			params.require(:comic).permit(:title, :desc, :img, :position)
		end
end