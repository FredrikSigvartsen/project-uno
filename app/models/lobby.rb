class Lobby < ActiveRecord::Base

	has_many :games

	def initilialize
		super
	end

	def add(game)
		if validate(game)
			games << game
		else
			return false
		end
		save
		reload
		game
	end

	def remove(game)
		games.delete(game)
		game
	end

	def validated? game
		#Check if game is active or not
		# game.active? 
		true
	end
end
