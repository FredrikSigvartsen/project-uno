class Game < ActiveRecord::Base
  # Attributes: :id, :host_id, :description, :updated_at, :created_at
  #has_many :users
  # validates :host_id, presence: true

  # Association
  has_many :game_tables
  has_one :chats
  has_many :users
  has_many :cards, through: :game_tables

  attr_reader :deck
  attr_reader :table
  attr_reader :current_card
  attr_reader :current_player
  attr_reader :current_color
  attr_reader :user_turn_queue

  MAX_NUMBER_PLAYERS = 2

  def create
    @number_players = 0
    @current_player = nil
    init_game_tables
    @deck = init_deck #Threat as stack
    @table = Array.new #Threat as stack
    @user_turn_queue = init_turn_queue
    @current_player = next_in_line
    deal_cards
    init_table_played_cards
    save
    reload
  end

  def init_game_tables
    cards = Card.all
    cards.each do |card|
      gamecard = GameTable.new
      gamecard.game_id = id
      gamecard.card_id = card.id
      gamecard.assign_to_deck
      game_tables << gamecard
    end
  end

  def init_deck
    new_deck = Card.all
    game_tables.each do |gamecard|
      card = Card.find(gamecard.card_id)
      new_deck.push(card)
      gamecard.assign_to_deck
    end
    new_deck = new_deck.shuffle
    save
    reload
    new_deck
  end

  def deal_cards
    users.each do |user|
      (0..6).each do |i|   #TODO: Find a way to test with the database
        card = deck_pop_and_assign_to(user)
        Pusher.trigger('game', 'card_drawn', 
          { card_id: card.id, user_id: user.id })
      end
    end
    save
    reload
  end

  def init_table_played_cards
    card = @deck.pop
    while( action_card?(card) || wild_card?(card))
      random_index = rand(@deck.length)
      @deck.insert(random_index, card) # put it back
      card = @deck.pop
    end
    @table.push( card )
    set_current_card_and_color(@table.last)
    gamecard = GameTable.find_by card_id: card.id
    gamecard.assign_to_played_card
    save
    reload
  end

  def init_turn_queue
    queue = Array.new
    users.each do |user|
      queue.push(user)
    end
    queue
  end

  def next_turn
    @current_player = next_in_line
  end

  def skip_next_turn
    player_skipped = next_in_line
  end

  def add_player(user) # Validation of user done with device, or do here too?
    if can_accomodate(user)
      user.game_id = id
      users << user
      save
      reload
      user
    else
      false
    end
    #TODO Push to client
    #status = "<b>#{user[:first_name]} #{user[:last_name]}</b> has joined"
    #push = {player: player, status: status}
    #Pusher.trigger("gameroom-#{id}", 'newplayer', push)
  end

  def remove_player(user)
    if !has_user?(user)
      return user
    elsif users.length == 2
      end_game
      return user
    else
      users.delete(user)
      user.game_id = -1
      return user
    end
    false
  end

  def end_game
    users.each do |user|
      user.game_id = -1
    end
  end

  def play_card(card, user, next_color = "")
    puts "your putting #{card} on top of color: #{@current_color} card: #{@current_card}"
    if ! user.eql? @current_player
      return false
    elsif ! validate_card(card)
      return false
    end

    color = card.color
    if action_card?(card)
      case card.value
      when 10
        skip_next_turn
      when 11
        reverse_queue
      when 12
        draw_two
      end
      next_turn
    elsif wild_card?(card)
      case card.value
      when 0  # wild card
        next_turn
      when 1
        draw_four
      end
      color = next_color
    else# Regular card
      next_turn
    end
    set_current_card_and_color(card, color)
    @table << card
    gamecard = GameTable.find_by card_id: card.id
    gamecard.assign_to_played_card
    save
    reload
    true
    # One card left?
  end

  def draw_four#Next player draws four and loses turn
    (0..3).each do |i|
      deck_pop_and_assign_to(get_next_player)
    end
    skip_next_turn
  end

  def reverse_queue
    @user_turn_queue = @user_turn_queue.reverse
    next_turn
  end

  def draw_two#Next player draws two, and loses turn
    (0..1).each do |i|
      deck_pop_and_assign_to(get_next_player)
    end
    skip_next_turn
  end

  def deck_pop_and_assign_to(user)
    card = @deck.pop
    gamecard = GameTable.find_by card_id: card.id
    gamecard.assign_to_user(user.id)
    card
  end

  def validate_card(card)
    if card.color.eql? @current_color
      return true
    elsif card.value.eql? @current_card.value
      return true
    elsif wild_card?(card)
      return true
    elsif @current_color.eql? card.color
      return true
    end
    false
  end

  def get_cards(user)
    all_cards = Array.new
    game_tables.each do |gamecard|
      if gamecard.user_id.eql? user.id
        all_cards << Card.find(gamecard.card_id)
      end
    end
    all_cards
  end

  def can_accomodate(user)
    if(!(users.length <= MAX_NUMBER_PLAYERS))
      false
    end
    !has_user?(user)
  end

  def has_user? user
    usernames = users.all.map(&:username)
    usernames.include?(user.username)
  end

  def action_card?(card)
    (10..12).cover?(card.value)
  end

  def wild_card?(card)
    (card.color.eql? "black") && (0..1).cover?(card.value)
  end

  def get_next_player
    @user_turn_queue[users.length-1]
  end

  def is_full?
    !(users.length <= MAX_NUMBER_PLAYERS)
  end

  def next_in_line
    el = @user_turn_queue.pop
    @user_turn_queue.unshift(el)
    el
  end

  def set_current_card_and_color(card, color = card.color)
    @current_card = card
    @current_color = color
  end

  def to_s
    "Game ID: #{id}, Host ID: #{host_id}\nDescription: #{description}"
  end
end
# Check - Initialize a random deck of card
# Check - Deal 7 cards to all the users.
# Check - Initialize the table deck, with a random card from the deck. Remember, action/wild card is not allowed
# Check - add_players and validation of player
# Check - remove_player
# Check - play_card(card, user)
# Check - next_turn
# Check - skip_turn
# Check - reverse_turn
# Check -  draw_four
# Check - draw_two(card)
# get_cards(user) [all cards] if user validates/ false
