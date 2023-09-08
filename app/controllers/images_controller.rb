class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]
  
  # GET /images
  def index
    if params[:id]
        @imagelines = Imageline.where(image_id: params[:id])
        session[:imagefile] = params[:id]
        upload = Upload.find(params[:id])
        @images = Image.where(upload: upload.id).page(params[:page]).per(1)
      else
        redirect_to games_path
      end
  end

  # GET /images/1
  def show
    session[:image] = params[:id]
    @imagelines = Imageline.where(image_id: params[:id])
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
    @imagelines = Imageline.where(image_id: params[:id])
  end

  # POST /images
  def create
    upload = Upload.find(session[:imagefile])
    @image = Image.new(image_params)
    @image.user_id = current_user.id
    @image.upload_id = session[:imagefile].to_i
    @image.game_id = Game.find(upload.game_id).id

    if @image.save
      redirect_to images_path(id: session[:imagefile]), info: "Image was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /images/1
  def update
    if @image.update(image_params)
      redirect_to @image, notice: "Image was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def imageline
    #("content LIKE ?", "%#{params[:query]}%")
    p session[:image]
    @line = Imageline.create()
    @line.image_id = session[:image].to_i
    @line.line_id = params[:line_id]
    @line.user_id = current_user.id
    @line.done = false
    @line.active = true
    
    respond_to do |format|
      if @line.save
        format.html { render plain: @line.id } # Sikeres művelet esetén "OK" válasz HTML formátumban
      else
        format.html { render plain: @line.errors.full_messages.join(", ") } # Hiba esetén hibaüzenet HTML formátumban
      end
    end
  end
  def imagelineremove
    Imageline.find(params[:line]).destroy    
  end
  
  
  # DELETE /images/1
  def destroy
    @image.destroy
    redirect_to images_url, notice: "Image was successfully destroyed.", status: :see_other
  end
  def search
    @line = Line.where("content ILIKE ?", "%#{params[:query]}%")
    respond_to do |format|
      format.json { render json: @line }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])      
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:title, :desc, :active, :done, :image)
    end
end
