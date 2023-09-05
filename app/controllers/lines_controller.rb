class LinesController < ApplicationController
  before_action :set_line, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy show index]
  # GET /lines
  def index
    if params[:id]
      session[:selected] = params[:id]
    end
    
    @updata = Upload.find(session[:selected])
    @stat0 = Line.where(datatype:1, uploadtype: session[:selected]).size
    @stat1 = Line.where(datatype:2, uploadtype: session[:selected]).where("oke IS NULL OR oke = ?", false).size
    @stat2 = Line.where(datatype:2, uploadtype: session[:selected], oke: true).size
    @q = Line.ransack(params[:q])
    @lines = @q.result().where(uploadtype: session[:selected], datatype: params[:q][:datatype_eq]).order(contentuid: :ASC).page(params[:page])
  end

  # GET /lines/1
  def show
  end
  
  # GET /lines/new
  def new
    @line = Line.new
  end

  # GET /lines/1/edit
  def edit
  end
  def create
    linecheck = Line.where(uploadtype: line_params[:uploadtype] ,contentuid: line_params[:contentuid], user:current_user.id, version:line_params[:version],datatype:2).first
    if !linecheck
      @line = Line.new(line_params)
    
      respond_to do |format|
        if @line.save
          format.html { redirect_to lines_path, notice: 'Sikeresen feévetted' }
          format.js   # Ez hivatkozik majd a create.js.erb fájlra
        else
          format.html { render :new }
          format.json { render json: @line.errors, status: :unprocessable_entity }
        end
      end
    else
      linecheck.oldcontent = line_params[:oldcontent]
      linecheck.oke = false
      respond_to do |format|
      if linecheck.save
        format.html { redirect_to lines_path, notice: 'Sikeresen feévetted' }
        format.js   # Ez hivatkozik majd a create.js.erb fájlra
      else
        format.html { render :new }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
      end
    end
      
  end
  # POST /lines
  def good
    respond_to do |format|
      line = Line.find(params[:id])
      Line.where(contentuid: line.contentuid, datatype: 2).update_all(oke: false)
      line.oke = true
      line.save
      format.js { render js: "window.location.reload();" }
    end
  end
  def bad
    respond_to do |format|
      line = Line.find(params[:id])
      line.oke = false
      line.save
      format.js { render js: "window.location.reload();" }
    end
  end

  def create2
    @line = Line.new(line_params)

    if @line.save
      redirect_to @line, notice: "Line was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  def translatecopy

    upload = Upload.find_by(selected: true)
    forditasok = Line.where(datatype:2, game_id: upload.game_id).where("uploadtype != ?", session[:selected])
    forditasok.each do |tom|
      eredeti = Line.where(datatype:1, uploadtype: params[:uploadtype], contentuid: tom.contentuid, content: tom.content, game_id: tom.game_id)
      if eredeti
        
        Line.find(tom.id).update(uploadtype: upload.id)
      end
    end
    redirect_to gameindex_path(game_id: upload.game_id), notice: "Amit lehet, átpakoltam."    
  end
  # PATCH/PUT /lines/1
  def update
    if @line.update(line_params)
      redirect_to @line, notice: "Line was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /lines/1
  def destroy
    @line.destroy
    redirect_to lines_url, notice: "Line was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_params
      params.require(:line).permit(:contentuid, :version, :oldcontent, :content, :linieref, :datatype, :game_id, :user_id, :uploadtype, :lang, :active)
    end
end
