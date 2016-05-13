require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def test_game
    game1 = Game.find(1)
    puts "#{game1}"
    game1.send( :create )
    gametable = GameTable.where( game_id: game1.id )
    gametable.each do |gamet| # TODO solve state of object problem
      puts gamet.to_s
    end
    #wildcard = Card.find(14)  # id=14 action green, id=3 wild, id=15 9 green, id=11 9 yellow
    #user = User.find(1)
    #user2 = User.find(2)
    #puts game1.send( :play_card, wildcard, user2)
    #somecard = Card.find(14)
    #puts game1.send( :play_card, somecard, user)
    #assert game1.save
    #assert game1.destroy

  end
end
