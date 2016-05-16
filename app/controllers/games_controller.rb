class GamesController < ApplicationController

  def index
    @message = Message.new
    render @game 
  end

  def newgame
    @game = Game.new
  end

  def create
    @game = Game.new #Testing purposes
    @game.host_id = current_user[:id]
    @game.description = game_params[:description]
    host = User.find(@game.host_id)
    @game.add_player(host)

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
    flash[:notice] = "#{host.username}, please wait for other players to join"
  end

  def update
    @game = Game.find(params[:game_id])
    cookies[:userid] = current_user[:id] || -1
    cookies[:gameid] = current_user[:game_id] || -1
    if current_user[:id] == @game.host_id
      if @game.start_game
        if @game.save
          redirect_to games_index_path

          #respond_to do |format|
          #format.html { redirect_to games_index_path }
          #format.js { head :ok }
          #end
        end
      else
        redirect_to games_index_path
        flash[:notice] = "Error! You can't start a game with one player"
      end
    else
      flash[:notice] = "Hosts only can start games"
      redirect_to games_index_path
    end
  end

  private
    def game_params
      params.require(:game).permit(:description)
    end
end
#Add logic for playing card
