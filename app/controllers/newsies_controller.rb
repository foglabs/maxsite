class NewsiesController < ApplicationController
  def destroy
    @newsie = Newsie.find(params[:id])
    @newsie.destroy

    redirect_to admin_comics_path
  end

end