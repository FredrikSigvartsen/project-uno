class GamesController < ApplicationController

  def index
    @game = Game.new
  end

  def newgame
    @game = Game.new
  end

  def create
    @game = Game.new #Testing purposes
    @game.host_id = current_user[:id]
    @game.description = game_params[:description]
    @game.add_player(current_user)

    cookies[:userid] = current_user[:id] || -1
    cookies[:gameid] = current_user[:game_id] || -1

    if @game.save
      redirect_to games_index_path
      user = User.find(@game.host_id)
      Pusher.trigger("lobby", "new_game",
        {game_id: @game.id}, description: @game.description, host: user.username, number_of_players: @game.users.length)
    else
      render 'new'
    end
    flash[:notice] = "There are #{@game.users.length} users in game #{@game.id}"
  end

  def update
    @game = Game.find(params[:game_id])
    if @game.start_game
      if @game.save
        redirect_to games_index_path
      end
    else
      redirect_to games_index_path
      flash[:notice] = "Error. Failed to start game"
    end
  end

  private
    def game_params
      params.require(:game).permit(:description)
    end
end
#Add logic for playing card
