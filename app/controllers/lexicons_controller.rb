class LexiconsController < ApplicationController
  before_action :set_lexicon, only: %i[ show edit update destroy ]

  # GET /lexicons
  def index
    @lexicons = Lexicon.all
  end

  # GET /lexicons/1
  def show
  end

  # GET /lexicons/new
  def new
    @lexicon = Lexicon.new
  end

  # GET /lexicons/1/edit
  def edit
  end

  # POST /lexicons
  def create
    @lexicon = Lexicon.new(lexicon_params)

    if @lexicon.save
      redirect_to @lexicon, notice: "Lexicon was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lexicons/1
  def update
    if @lexicon.update(lexicon_params)
      redirect_to @lexicon, notice: "Lexicon was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /lexicons/1
  def destroy
    @lexicon.destroy
    redirect_to lexicons_url, notice: "Lexicon was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lexicon
      @lexicon = Lexicon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lexicon_params
      params.require(:lexicon).permit(:user_id, :word, :active, :wordhu, :lang)
    end
end
