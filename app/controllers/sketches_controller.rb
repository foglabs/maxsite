class SketchesController < ApplicationController

  def update
    Sketch.update(sketch_params)
  end

  def create
    Sketch.create(sketch_params)
  end

  private
    def sketch_params
      params.require(:sketch).permit(:working, :info)
    end
end