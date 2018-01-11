class ArcsController < ApplicationController

  def index
    @arcs = Arc.where(enabled: true).order(created_at: :asc).all
  end

  # def show
  #   # list of storylines
  #   @arcs = Arc.all
  # end

  def create
    @arc = Arc.create(arc_params)
    @arc.enabled = false

    if @arc.save
      redirect_to admin_comics_path
    else
      render 'comics/admin'
    end
  end

  def save_arc
    maxy = Comic.maximum(:position)
    @arc = Arc.find(params[:arc_id])
    pos = Arc.where(enabled: true).count + 1

    params[:comicDetails].each do |k,v|
      @comic = Comic.find(v[:comic][:id])
      @comic.position = v[:comic][:pos].to_i + maxy
      @comic.desc = v[:comic][:desc]
      @comic.title = v[:comic][:title]
      @comic.arc_id = params[:arc_id]

      @comic.enabled = true
      @comic.save
    end

    @arc.arc_position = pos
    @arc.enabled = true
    @arc.save
  end

  def new
    @arc = Arc.new
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.destroy
    redirect_to admin_comics_path
  end

  private
    def arc_params
      params.require(:arc).permit(:title)
    end
end