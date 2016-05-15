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

    if @game.users.length > 1
      @game.create
      @game.users.each do |user| 
        @game.get_cards(user).each do |card|
          puts "Card #{card.id}"
          Pusher.trigger('game', 'card_drawn', 
          { card_id: card.id, user_id: user.id })
        end 
      end
    end
    if @game.save
      redirect_to game_tables_index_path
    else
      render 'new'
    end
    flash[:notice] = "There are #{@game.users.length} users in game #{@game.id}"
  end

  def rules
  end

  private
  def game_params
    params.require(:game).permit(:description)
  end
end
