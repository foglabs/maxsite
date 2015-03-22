class ComicsController < ApplicationController

	def index
		@comic = Comic.last
		@news = Newsie.last(10)
		@tags = Tag.all
	end

	def show
		# change to give appropriate news from displayed comic
		@news = Newsie.last(10)
		@tags = Tag.all
		@tag = Tag.new
		@comic_tag = ComicTag.new

 		@comic = Comic.find(params[:id])

 		@taggy = []
		ComicTag.where(comic_id: @comic.id).each {|a| @taggy << a.tag }.uniq

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
			params.require(:comic).permit(:title, :desc, :img, :position, comic_tag_attributes: [:comic_id, :tag_id])
		end
end