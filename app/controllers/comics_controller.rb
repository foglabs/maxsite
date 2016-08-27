class ComicsController < ApplicationController
	require 'login'
	layout "admin", only: :admin

	before_filter :errybody

# login
	def errybody
		@sess = Session.where(code: request.remote_ip).first
		@news = Newsie.order('created_at desc').last(10)
		@tags = Tag.all
	end

	def login
		@logging = Login.new(nil)
	end

	def logout
		@sess = Session.where(code: request.remote_ip).first
		Session.destroy_all
		redirect_to comics_path
	end

# backoffice!
	def auth
		@logging = params[:pass] ? Login.new(params[:pass]) : nil

	 	unless @logging.validate_pw
	 		redirect_to login_comics_path
	 	else
	 		@sess = Session.create(code: request.remote_ip)
	 		redirect_to admin_comics_path
	 	end
	end

	def admin
		unless @sess.try(:check)
			redirect_to comics_path
		else
		
			@comics = Comic.all.order(created_at: :asc)
			@news = Newsie.all

			@comic = Comic.new
			@newsie = Newsie.new
		end
	end

	def upload
		# para = ActionController::Parameters.new({comic: {image: params[:image]}})
		@comic = Comic.create(comic_params)

		# render nothing: true, status: 200, body:
		render json: {id: @comic.id}
	end

#####

# static stuff!
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

			# @taggy = []
			# ComicTag.where(comic_id: @comic.id).each {|a| @taggy << a.tag }.uniq

			@a = @comic.lastcom
			@b = @comic.nextcom
		end
	end
#####

	def show
		# change to give appropriate news from displayed comic
		@comm = Comment.new
		@comms = Comment.where(comic_id: params[:id])

 		@comic = Comic.find(params[:id])
		@a = @comic.lastcom
		@b = @comic.nextcom
	end

	def create
		@comic = Comic.create(comic_params)

		if @comic.save
			redirect_to admin_comics_path
		else
			render 'comics/admin'
		end
	end

	def new
		@comic = Comic.new
	end

	def edit
		unless @sess.try(:check)
			redirect_to comics_path
		else

	  	@comic = Comic.find(params[:id])
		end
	end

	def update
	  @comic = Comic.find(params[:id])

	  if @comic.update(comic_params)
	    redirect_to admin_comics_path
	  else
	    render('edit')
	  end
	end

	def destroy
		@comic = Comic.find(params[:id])
		@comic.destroy
		redirect_to admin_comics_path
	end

	private
		def comic_params
			params.require(:comic).permit(:title, :desc, :image, :position, comic_tag_attributes: [:comic_id, :tag_id])
		end
end