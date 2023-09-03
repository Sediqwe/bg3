class LinesController < ApplicationController
  before_action :set_line, only: %i[ show edit update destroy ]

  # GET /lines
  def index
    @q = Line.ransack(params[:q])
    @lines = @q.result().where(datatype: 1).order(contentuid: :ASC).page(params[:page])
    
    
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
    @line = Line.new(line_params)
  
    respond_to do |format|
      if @line.save
        format.html { redirect_to lines_path, notice: 'Sikeresen létrehoztad a vonalat!' }
        format.js   # Ez hivatkozik majd a create.js.erb fájlra
      else
        format.html { render :new }
        format.json { render json: @line.errors, status: :unprocessable_entity }
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
      params.require(:line).permit(:contentuid, :version, :content, :linieref, :datatype, :game_id, :user_id, :uploadtype, :lang, :active)
    end
end
