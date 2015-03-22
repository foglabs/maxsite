class ComicTagsController < ApplicationController

  def new
    @comic_tag = ComicTag.new
  end

  def create
    @comic_tag = ComicTag.new(comic_tag_params)
    @comic_tag.save
  end

  def destroy
    @comic_tag = ComicTag.find(params[:id])
    @comic_tag.destroy
  end


  def comic_tag_params
    params.require(:comic_tag).permit(:comic_id, :tag_id)
  end
end