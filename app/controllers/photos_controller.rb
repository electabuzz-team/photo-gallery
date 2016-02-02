class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @map = params[:map] || false
    @photos = Photo.where(published: true)
  end

  def search
    @photo
    render 'search'
  end

  def search_photo
    if params[:name] && !params[:name].empty?
      @photos = Photo.where("name LIKE ?","%#{params[:name]}%").where(published: true)
    elsif params[:longitude] && params[:latitude] && params[:radius]
      bounds = Geokit::Bounds.from_point_and_radius([ params[:latitude], params[:longitude]], params[:radius])
      @photos = Photo.in_bounds(bounds).all.where(published: true)
    else
      @photos = Photo.all.where(published: true)
    end
    render 'index'
  end


  def search_photo_json
    if params[:name] && !params[:name].empty?
      @photos = Photo.where("name LIKE ?","%#{params[:name]}%").where(published: true)
    elsif params[:longitude] && params[:latitude] && params[:radius]
      bounds = Geokit::Bounds.from_point_and_radius([ params[:latitude], params[:longitude]], params[:radius])
      @photos = Photo.in_bounds(bounds).all.where(published: true)
    else
      @photos = Photo.all.where(published: true)
    end
    render :json => @photos
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def photo_params
    params.require(:photo).permit(:name, :description, :published, :photo, :latitude, :longitude)
  end
end
