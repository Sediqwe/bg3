class UploadsController < ApplicationController
  before_action :set_upload, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy show index]
  # GET /uploads
  def gameindex
    @uploads = Upload.where(game_id: params[:game_id])
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
      log = Logola.new
      log.user = current_user
      log.page = "Page: Uploads#Create"
      log.desc = "Új feltöltött XML file. #{@upload.game.name} (#{@upload.file.filename})(#{@upload.version})"
      log.save

      redirect_to @upload, notice: "Upload was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /uploads/1
  def update
    if @upload.update(upload_params)
      redirect_to @upload, notice: "Upload was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /uploads/1
  def destroy
    log = Logola.new
    log.user = current_user
    log.page = "Page: Uploads#Destroy"
    log.desc = "XML file letörölve. #{@destroy.inspect}"
    log.save
    @upload.destroy
    redirect_to uploads_url, notice: "Upload was successfully destroyed.", status: :see_other
  end

  #Read xml
  def readxml
    cfile = Upload.find(params[:id]) # Project ID lekérés
    userid = User.first.id
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
          uploadtype: cfile.id,
          game_id: cfile.game_id,
          user_id: userid,
          created_at: Time.now,
          updated_at: Time.now
        }
      end
    
      # Az adatok betöltése az adatbázisba
      Line.insert_all(translation_content)
    
      cfile.active = true # Elmentjük az uploadot, hogy ez már fel van véve!
      cfile.save
    else
      # Kezeljük az esetet, amikor nincs csatolt fájl
      puts "Nincs csatolt fájl a projektben"
    end
    redirect_to uploads_path
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
      params.require(:upload).permit(:version, :game_id, :uploadtype, :active, :file, :lang)
    end
end
