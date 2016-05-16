class LobbyController < ApplicationController

	def new
		@lobby = Lobby.new # Only create once when server starts
		@games = Game.all
	end

	def index		
		@lobby = Lobby.new # Only create once when server starts
		@games = Game.all
	end

	def create

	end

	def update
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

	end

	def show

	end
end
