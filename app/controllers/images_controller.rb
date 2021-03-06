class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end
  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to @image, notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  def update
    if @image.update(image_params)
      redirect_to @image, notice: 'Image was successfully updated.'
    else
      render :edit
    end
  end

  def edit
    @image= Image.find(params[:id])
  end

  def show
    @image = Image.find(params[:id])
    @size = ((@image.picture_file_size/1024.0/102.4).round/10.0).to_s + "MB"

  end
  def original
    @image= Image.find(params[:id])
    @size = ((@image.picture_file_size/1024.0/102.4).round/10.0).to_s + "MB"
  end
end
