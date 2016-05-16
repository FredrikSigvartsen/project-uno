class LobbyController < ApplicationController

	def new
		@lobby = Lobby.new # Only create once when server starts
		@games = Game.all
	end

	def index		
		@lobby = Lobby.new # Only create once when server starts
		@games = Game.all
	end

	def update
		game = Game.find(params[:game_id])
		if !game.nil? 
			if ! game.add_player(current_user)
				redirect_to lobby_index_path
				flash[:notice] = "This game is full"
			else
				redirect_to games_index_path
			end
		else
			redirect_to lobby_index_path
			flash[:notice] = "Error. This game does not exist"
		end
	end

	def show
		flash[:notice] = "You did it"
	end

	def create
	end


	def show

	end
end


#Check if the game is in session or not
#Pusher.trigger('lobby', 'someaction')


#Check if the game is in session or not
# Server sends information back to 
# Listen in view JavaScript for channel and event, channel lobby and event new_game
# In GamesController create: Pusher.trigger( 'lobby', 'new_game', {game_id: id});
# In javascript listening to channel 'lobby' and event 'new_game':
# (function ($) { 

#channel.bind('card_drawn', function (data) {
#  //$('#hand').append('<%= image_tag "cards/card_' + data.card_id + '.png", :id => "card" %>');
#  console.log("Answer from pusher: " + data.card_id);
#});
#})(jQuery);

