class CommentsController < ApplicationController

  def index
    @comms = Comment.all

  end

  def show
    @comm = Comment.find(params[:id])
  end

  def new
    @comm = Comment.new
  end

  def create
    @comm = Comment.new(comment_params)

    if @comm.save
      redirect_to comic_path(@comm.comic.id)
    else
      render 'new'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :comic_id, :name)
    end
end