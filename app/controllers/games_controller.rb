class GamesController < ApplicationController
  
  def index
  end

  def newgame
    @game = Game.new
  end

  def create
    @game = Game.new
    @game.host_id = current_user[:id]
    @game.description = game_params[:description]
    @game.create
    if @game.save
      redirect_to game_tables_index_path
    else
      render 'new'
    end
  end

  def rules
    
  end

  private

    def game_params
      params.require(:game).permit(:description)
    end
end
