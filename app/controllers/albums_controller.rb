class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)

    respond_to do |format|
      if @album.save
        if params[:pictures]
          #=====  Magic!!!!!!!!
          params[:pictures].each { |p| @album.images.create(picture: p, description: "") }
        end
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    @album.images.each_with_index do |i,d|
      i.update(:description => params[:album][:images][d][:description])
    end

    if @album.update(album_params)
      if params[:pictures]
        params[:pictures].each { |p| @album.images.create(picture: p) }
      end
      redirect_to @album, notice: 'Album was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album= Album.find(params[:id])
    @album.destroy # TODO : If destroy failed?
    #flash[:notice] = "删除成功 ID=" + params[:id] # TODO : Multilingual/I18n
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:name, :description)
    end
end
