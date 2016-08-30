class ArcsController < ApplicationController

  def show
    # list of storylines
    @arcs = Arc.all
  end

  def create
    @arc = Arc.create(arc_params)

    if @arc.save
      redirect_to admin_comics_path
    else
      render 'comics/admin'
    end
  end

  def save_arc

    binding.pry

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