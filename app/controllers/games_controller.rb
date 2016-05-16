class GamesController < ApplicationController

  def index
  end

  def newgame
    @game = Game.new
  end

  def create
    @game = Game.find(9) #Testing purposes
    if( @game.users.length == 0)
      @game.host_id = current_user[:id]
      @game.description = game_params[:description]
      @game.add_player(current_user)
    elsif( @game.users.length == 1)
      @game.add_player(current_user)
    end

    cookies[:userid] = current_user[:id] || -1
    cookies[:gameid] = current_user[:game_id] || -1

    if @game.save
      redirect_to games_index_path
      Pusher.trigger("lobby", "new_game",
                     {game_id: @game.id})
    else
      render 'new'
    end
    flash[:notice] = "There are #{@game.users.length} users in game #{@game.id}"
  end

  def update
    @game = Game.find(9)
    @game = @game.start_game
    if @game.save
      redirect_to games_index_path
    end
  end

  private
  def game_params
    params.require(:game).permit(:description)
  end
end
