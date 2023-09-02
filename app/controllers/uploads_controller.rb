class UploadsController < ApplicationController
  before_action :set_upload, only: %i[ show edit update destroy ]

  # GET /uploads
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
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def upload_params
      params.require(:upload).permit(:version, :game_id, :uploadtype, :active, :file)
    end
end
