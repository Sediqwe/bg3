class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]
  before_action :authorized?, only: %i[new edit update destroy show index]

  # GET /games
  def index
    @games = Game.all.order(id: :ASC)
  end

  # GET /games/1
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    
    @game = Game.new(game_params)
    
    if @game.save
      create_log("Games#Create","Új adatlap létrehozva: #{@game.name}")  
      redirect_to games_path, notice: "Game was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /games/1
  def update
    create_log("Page: Games#Update", "Játék adatlap módosítva:  #{@game.name}")
    if @game.update(game_params)
      redirect_to @game, notice: "Game was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    create_log("Page: Games#Destroy", "Játék adatlap törölve: #{@game.name}")
      @game.destroy
      redirect_to games_url, notice: "Game was successfully destroyed.", status: :see_other
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name, :desc, :active, :gameimage)
    end
end
