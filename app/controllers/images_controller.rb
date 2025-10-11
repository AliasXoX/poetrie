class ImagesController < ApplicationController
  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to @image, notice: "Image was successfully uploaded."
    else
      render json: { errors: @image.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def image_params
    params.require(:image).permit(:image_file, :title)
  end
end
