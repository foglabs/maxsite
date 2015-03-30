class NewsiesController < ApplicationController

  def destroy
    @newsie = Newsie.find(params[:id])
    @newsie.destroy
    redirect_to admin_comics_path
  end

  def create
    @newsie = Newsie.new(newsie_params)

    if @newsie.save
      redirect_to admin_comics_path
    else
      render 'new'
    end
  end

  private
    def newsie_params
      params.require(:newsie).permit(:title, :body)
    end
end