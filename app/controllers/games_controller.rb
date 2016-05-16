class GamesController < ApplicationController
  
  def index
  end

  def newgame
    @game = Game.new
  end

  def create
    
    @game = Game.new(game_params)
    if @game.save
      redirect_to game_tables_index_path
    #else
    #  render 'new'
    end
  end

  private
    def game_params
      params.require(:game).permit(:host_id,:description)
    end
end
# Unchecked - Create a game correctly with host_id and description
# Unchecked - After creating a game, also initialize it on the model
# Unchecked - Let users join games, and host to remove users. 
# Unchecked - Let a player play or draw a card
# Unchecked - Let host wait for users to start game
