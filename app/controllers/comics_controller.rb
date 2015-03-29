class ComicsController < ApplicationController

	def index
		@comic = Comic.last
		@news = Newsie.last(10)

		@comms = Comment.where(comic_id: @comic.id)
		@comm = Comment.new

		@tags = Tag.all
		@tag = Tag.new

 		@taggy = []
		ComicTag.where(comic_id: @comic.id).each {|a| @taggy << a.tag }.uniq
	end

	def show
		# change to give appropriate news from displayed comic
		@comm = Comment.new
		@comms = Comment.where(comic_id: params[:id])
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
		@tags = Tag.all
		@news = Newsie.last(10)
		@comic = Comic.new
	end

	private
		def comic_params
			params.require(:comic).permit(:title, :desc, :img, :position, comic_tag_attributes: [:comic_id, :tag_id])
		end
end