require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def test_game
    game1 = Game.find(1)
    puts game1.to_s
    puts game1.game_tables
    puts game1.users
    game1.send( :initialize )
    gametable = GameTable.find_by game_id: game1.id
    gametable.each do |gamet|
      puts gamet.to_s
    end
    assert game1.save
    assert game1.destroy
    
  end
end
