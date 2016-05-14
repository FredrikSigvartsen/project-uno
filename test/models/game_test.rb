require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def test_game
    game1 = Game.find(1)
    user1 = User.find(1)
    user2 = User.find(2)
    game1.send( :add_player, user1)
    game1.send( :add_player, user2)
    game1.send( :create )
    gametable = GameTable.where( game_id: game1.id )
    wildcard = Card.find(3)
    draw_four = Card.find(1)
    bluecard3 = Card.find(5)
    greencard3 = Card.find(6)
    red_draw2 = Card.find(4)
    green_reverse = Card.find(14)

    gametable.each do |gamet| # TODO solve state of object problem
      puts gamet.to_s
    end

    #game1.send( :play_card, greencard3, user2 )
    #puts "---Current player before reverse #{game1.current_player}---"
    #puts "next player : #{game1.send( :get_next_player )} "
    #puts game1.send( :play_card, green_reverse, user2 )
    #puts "---Current player after reverse #{game1.current_player}---"
    #puts "next player : #{game1.send( :get_next_player )} "
    #game1.send( :play_card(card, user) )

    #puts game1.user_turn_queue

    #gametable.each do |gamet| # TODO solve state of object problem
    #  puts gamet.to_s
    #end
    #puts "---Current card and color: #{game1.current_card.value}, #{game1.current_color}"
    #puts "---Current player #{game1.current_player}---"
    #puts "next player : #{game1.send( :get_next_player )} "
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
