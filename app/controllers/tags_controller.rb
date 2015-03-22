class TagsController < ApplicationController

  def create
    puts params
    @tag = Tag.where(word: params[:tag][:word].downcase).first

    unless @tag
      @tag = Tag.create(tag_params)
      @tag.word = @tag.word.downcase
      @tag.save
    end

    @comic_tag = ComicTag.where(comic_id: params[:tag][:comic_id], tag_id: @tag.id).first

    unless @comic_tag
      @comic_tag = ComicTag.create(comic_id: params[:tag][:comic_id], tag_id: @tag.id)
      @comic_tag.save
    end

    redirect_to tag_path(@tag)
  end

  def new
    @tag = Tag.new
  end

  def show
    @news = Newsie.all
    @tag = Tag.find(params[:id])
    @tags = Tag.all
    @comics = @tag.comics
  end

  private
    def tag_params
      params.require(:tag).permit(:word )
    end
end