class VideosController < ApplicationController
  def index
    #@videos = Video.all
  end

  def create
    uploaded_io = params[:video]
    @position = Rails.root.join('public', 'media', uploaded_io.original_filename)
    File.open(@position, 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end
end
