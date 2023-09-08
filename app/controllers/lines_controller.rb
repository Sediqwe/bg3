class LinesController < ApplicationController
  before_action :set_line, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy show index]
  # GET /lines
  def index
    if params[:id]
      session[:selected] = params[:id]
    end
    if params[:q]
      para = params[:q]["datatype_eq"]
    else
      para = 1
    end
    @updata = Upload.find(session[:selected])
    @stat0 = Line.where(datatype:1, upload_id: session[:selected]).size
    @stat1 = Line.where(datatype:2, upload_id: session[:selected]).where("oke IS NULL OR oke = ?", false).size
    @stat2 = Line.where(datatype:2, upload_id: session[:selected], oke: true).size
    @q = Line.ransack(params[:q])
    @lines = @q.result().where(upload_id: session[:selected], datatype: para).order(contentuid: :ASC).page(params[:page]).per(1)





    input_text = '<LSTag Tooltip="MovementSpeed">Movement Speed</LSTag>: [1]/[2]'

# Regex minta a <LSTag> és </LSTag> közötti tartalom kinyeréséhez
tag_pattern = /<LSTag Tooltip="(.*?)">(.*?)<\/LSTag>/

# Találatok listája
matches = input_text.scan(tag_pattern)

# Kezdeti HTML tartalom
html_content = ''

# Egyes találatok feldolgozása
matches.each do |match|
  tooltip = match[0]
  content = match[1]

  # LSTag div
  lstag_div = "<div class='btn btn-success' data='Tooltip=#{tooltip}'>LSTag</div>"

  # Input text
  input_text = "<input type='text' value='#{content}'></input>"

  # /LSTag div
  lstag_end_div = "<div class='btn btn-success' data=''>/LSTag</div>"

  # Az összes elemet hozzáadjuk az HTML tartalomhoz
  html_content += "#{lstag_div}\n#{input_text}\n#{lstag_end_div}\n"
end

# A teljes tartalom kerül a container div-be
@result = "<div class='container'>\n#{html_content}:[1][2]\n</div>"





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
    
    linecheck = Line.where(upload_id: line_params[:upload_id] ,contentuid: line_params[:contentuid], user:current_user.id, version:line_params[:version],datatype:2).first
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
      create_log("Page: Lines#Create#Else", "Fordítás felvéve: #{line_params[:content] + " ==>\n" + line_params[:oldcontent] + "=>(" + Game.find(line_params[:game_id]).name +  ")" }")
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

  def translatecopy
    create_log("Page: Lines#Translatecopy", "Fordítás átpakolva az aktív fájlba")
    upload = Upload.find_by(selected: true)
    forditasok = Line.where(datatype:2, game_id: upload.game_id).where("upload_id != ?", session[:selected])
    forditasok.each do |tom|
      eredeti = Line.where(datatype:1, upload_id: params[:upload_id], contentuid: tom.contentuid, content: tom.content, game_id: tom.game_id)
      if eredeti
        
        Line.find(tom.id).update(upload_id: upload.id)
      end
    end
    redirect_to gameindex_path(game_id: upload.game_id), notice: "Amit lehet, átpakoltam."    
  end
  # PATCH/PUT /lines/1
  def update
    create_log("Page: Lines#Update", "Fordítási sor felülírva")
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
      params.require(:line).permit(:contentuid, :version, :oldcontent, :content, :linieref, :datatype, :game_id, :user_id, :upload_id, :lang, :active)
    end
end
