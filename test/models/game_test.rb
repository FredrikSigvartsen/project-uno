require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def test_game
    game1 = Game.find(1)
    game1.send( :create )
    gametable = GameTable.where( game_id: game1.id )
    #    gametable.each do |gamet| # TODO solve state of object problem
    #      puts gamet.to_s
    #    end
    user = User.find(1)
    gametables = GameTable.where( game_id: 1 )
    gametables.each do |gamecard|
    	card = Card.find(gamecard.card_id)
    end
    puts game1.users 
    #assert game1.save
    #assert game1.destroy

  end
end
