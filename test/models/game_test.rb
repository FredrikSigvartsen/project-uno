require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def test_game
    game1 = Game.find(1)
    puts game1.to_s
  end
end
