require 'test_helper'

class GameTableTest < ActiveSupport::TestCase
  test "the truth" do

    GameTable.find_each do |gt|
      puts gt.to_s
      assert gt.save
      assert gt.destroy
    end
  end
end
