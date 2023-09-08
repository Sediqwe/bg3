class UploadsController < ApplicationController
  before_action :set_upload, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy show index]
 
  include UploadsHelper
  # GET /uploads
  def gameindex
    @uploads = Upload.where(game_id: params[:game_id]).order(id: :ASC)

  end
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  def create
    @upload = Upload.new(upload_params)
    @upload.user_id = User.first.id
    if @upload.save
      create_log( "Page: Uploads#Create", "Feltöltés megtörtént. #{@upload.game.name} , v. #{@upload.version}, uploader:  #{@upload.user.name}")
      redirect_to @upload, notice: "Upload was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /uploads/1
  def update
    create_log( "Page: Uploads#Update", "Feltöltés módosítva. #{@upload.game.name}")
    if @upload.update(upload_params)
      redirect_to @upload, notice: "Upload was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /uploads/1
  def destroy
    create_log( "Page: Uploads#Destroy", "XML file letörölve. #{@upload.game.name}, version: #{@upload.version} Törölt felvett sorok: #{Line.where(file_id: @upload.id).size}")
    @upload.destroy
    redirect_to uploads_url, notice: "Upload was successfully destroyed.", status: :see_other
  end
  def active
    upload = Upload.find(params[:id])
    Upload.where(game_id: upload.game_id).update(selected: false)
    upload.selected = true
    upload.save
    session[:selected] = params[:id]
    create_log("Page: Uploads#Active", "Kijelölt fő verzió aktiválva. #{upload.game.name}")
    redirect_to gameindex_path(game_id: upload.game_id)
  end
  #Read xml
  def readxml
    upload = Line.where(upload_id: params[:id]).first # Próbáld megtalálni a megadott ID-jű upload-ot
    cfile = Upload.find(params[:id]) # Project ID lekérés
    if !upload
      cfile = Upload.find(params[:id]) # Project ID lekérés
      userid = current_user.id
      if cfile.file.attached? # Ellenőrizzük, hogy van-e csatolt fájl
        t = cfile.file # A projecthez tartozó fájlt lekérjük
        filepath = ActiveStorage::Blob.service.send(:path_for, t.key) # Adatok a fájlról
        # Beolvassuk a fájlt
        data = File.read(filepath)
        # Fájl tartalmának feldolgozása Nokogiri segítségével
        doc = Nokogiri::XML(data)
        content_list = doc.xpath('//content')    
        translation_content = []    
        # Minden <content> elem feldolgozása
        content_list.each_with_index do |content, index|
          contentuid = content['contentuid']
          version = content['version']
          content_text = content.text
          translation_content << {
            contentuid: contentuid,
            version: version,
            content: content_text,
            datatype: cfile.uploadtype,
            upload_id: cfile.id,
            game_id: cfile.game_id,
            user_id: userid,
            created_at: Time.now,
            updated_at: Time.now
          }
        end
      
        # Az adatok betöltése az adatbázisba
        Line.insert_all(translation_content)
      
        cfile.readxml = true # Elmentjük az uploadot, hogy ez már fel van véve!
        cfile.save
      else
        # Kezeljük az esetet, amikor nincs csatolt fájl
        puts "Nincs csatolt fájl a projektben"
      end
    end
    redirect_to gameindex_path(game_id: cfile.game_id)
  end
  

  def download
    up = Upload.find(params[:id])
  
    # Az SQL lekérdezés segítségével kiválasztjuk azokat a sorokat, amelyeknek uploadtype = 1 ÉS vagy a contentuid megegyezik a valid_contentuids-ben található értékekkel, vagy nincs találat
    lines = Line.joins("LEFT JOIN lines AS controllines ON lines.contentuid = controllines.contentuid AND lines.version = controllines.version AND controllines.datatype = 2 AND controllines.oke = true")
                .where(uploadtype: params[:id], datatype: 1)
                .order(id: :ASC)
                .select("lines.content, lines.contentuid, lines.version, COALESCE(controllines.content, lines.content) AS controlled_content")
  
    # XML generálás Builder::XmlMarkup segítségével
    require 'builder'
    xml_data = Builder::XmlMarkup.new(indent: 2)
    xml_data.instruct! :xml, encoding: 'utf-8'
  
    xml_data.contentList do
      lines.each do |line|
        xml_data.content(line.controlled_content, contentuid: line.contentuid, version: line.version)
      end
    end
  
    # Az XML adatokat egy temporális fájlba mentjük
    tmp_xml_file = Rails.root.join('tmp', up.file.filename.to_s)
    File.open(tmp_xml_file, 'w') do |file|
      file.write(xml_data.target!)
    end
  
    # A fájlt letöltjük a böngészőbe
    send_file(tmp_xml_file, filename: up.file.filename.to_s, type: 'application/xml')
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def upload_params
      params.require(:upload).permit(:version, :game_id, :upload, :active, :file, :lang)
    end
end
