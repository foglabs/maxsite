class ComicsController < ApplicationController
	layout "admin", only: :admin

	before_filter :errybody
	before_filter :login, only: :admin

	def errybody
		@news = Newsie.last(10)
		@tags = Tag.all
	end

	def login
		@logging = Login.new('')
	end

	def log_me_in
		@logging = Login.new(params[:pass])

	 	if @logging.log_in(@logging.pass_attempt)
	 		redirect_to admin_comics_path
	 	else
	 		redirect_to comics_path
	 	end
	end

	def admin
		@comics = Comic.all.order(created_at: :asc)
		@news = Newsie.all

		@comic = Comic.new
		@newsie = Newsie.new
	end

	def storysofar
		@comm = Comment.new
		@comms = Comment.where(comic_id: params[:id])
		@tag = Tag.new
		@comic_tag = ComicTag.new
	end

	def index
		@comic = Comic.last

		if @comic
			@comms = Comment.where(comic_id: @comic.id)
			@comm = Comment.new

			@tag = Tag.new

			@taggy = []
			ComicTag.where(comic_id: @comic.id).each {|a| @taggy << a.tag }.uniq
		end
	end

	def show
		# change to give appropriate news from displayed comic
		@comm = Comment.new
		@comms = Comment.where(comic_id: params[:id])
		@tag = Tag.new
		@comic_tag = ComicTag.new

 		@comic = Comic.find(params[:id])

 		@taggy = []
		ComicTag.where(comic_id: @comic.id).each {|a| @taggy << a.tag }.uniq
	end

	def create
		@comic = Comic.create(comic_params)

		if @comic.save
			redirect_to admin_comics_path
		else
			render 'new'
		end
	end

	def new
		@comic = Comic.new
	end

	def destroy
		@comic = Comic.find(params[:id])
		@comic.destroy
		redirect_to admin_comics_path
	end

	private
		def comic_params
			params.require(:comic).permit(:title, :desc, :img, :position, comic_tag_attributes: [:comic_id, :tag_id])
		end
end