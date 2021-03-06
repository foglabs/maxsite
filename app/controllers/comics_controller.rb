class ComicsController < ApplicationController
	require 'login'
	layout "admin", only: :admin

	before_filter :errybody

# login
	def errybody
		@sess = Session.where(code: request.remote_ip).first
		@news = Newsie.order('created_at desc').last(10)
		# @tags = Tag.all
	end

	def login
		@logging = Login.new(nil)
	end

	def logout
		if @sess
			Session.destroy_all
		end
		
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
		
			@comics = Comic.where(enabled: true).order(position: :asc).all
			@arcs = Arc.all.order(created_at: :asc)
			@news = Newsie.all

			if @sketch = Sketch.where(working: true).first
				# get count from sketch..
				# session[:comics_count] = 
			else
				session[:comics_count] = 1
			end

			@cnt = session[:comics_count]

			@arc = Arc.new
			@comic = Comic.new
			@newsie = Newsie.new
		end
	end

	def upload
		maxy = Comic.maximum(:position)

		if !maxy
			maxy = 0
		end

		params[:comic][:position] = (maxy + 1)
		params[:comic][:enabled] = false
		@comic = Comic.create(comic_params)
		render json: {id: @comic.id}
	end

	def new_comic
		@comic = Comic.new
		# session[:comics_count] ? nil : session[:comics_count] = 1
		@cnt =  session[:comics_count]

	  respond_to do |format|               
	    format.js {render 'comics/new_comic'}
	  end        
	end

	def count

		if session[:comics_count]
			session[:comics_count] += 1
		else

			session[:comics_count] = 1
		end

		render json: {count: session[:comics_count]}
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
		# show us the first page of the newest arc
		@comic = Arc.where(enabled: true).last.comics.where(enabled: true).order(position: :asc).first

		if @comic
			@comms = Comment.where(comic_id: @comic.id)
			@comm = Comment.new

			@arc = @comic.arc

			# @taggy = []
			# ComicTag.where(comic_id: @comic.id).each {|a| @taggy << a.tag }.uniq

			c1 = @comic.lastcom
			c2 = @comic.nextcom
			c3 = @arc.lastarc
			c4 = @arc.nextarc

			@a = c1 ? "/comics/#{c1.id}" : "#"
			@b = c2 ? "/comics/#{c2.id}" : "#"
			@c = c3 ? "/comics/#{c3.id}" : "#"
			@d = c4 ? "/comics/#{c4.id}" : "#"
		end
	end
#####

	def show
		# change to give appropriate news from displayed comic
		@comm = Comment.new
		@comms = Comment.where(comic_id: params[:id])

 		@comic = Comic.find(params[:id])
 		@arc = @comic.arc

		c1 = @comic.lastcom
		c2 = @comic.nextcom
		c3 = @arc.lastarc
		c4 = @arc.nextarc

		@a = c1 ? "/comics/#{c1.id}" : "#"
		@b = c2 ? "/comics/#{c2.id}" : "#"
		@c = c3 ? "/comics/#{c3.id}" : "#"
		@d = c4 ? "/comics/#{c4.id}" : "#"
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
			params.require(:comic).permit(:title, :desc, :image, :position, :enabled, comic_tag_attributes: [:comic_id, :tag_id])
		end
end