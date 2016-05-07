class Game < ActiveRecord::Base
  # Attributes: :id, :host_id, :description, :updated_at, :created_at
  #has_many :users
  validates :host_id, presence: true

  # Association
  has_many :game_tables
  has_one :chats
  #has_many :game_users
  #has_many :users, through: :game_users
  has_many :users
  has_many :cards, through: :game_tables

  attr_reader :deck
  attr_reader :table
  attr_reader :current_card # Do we need this?
  attr_reader :current_player
  attr_reader :current_color 

  MAX_NUMBER_PLAYERS = 6

  def create
    puts "------------ Initializing Game #{id} with Host #{host_id} --------------\n"
    @deck = init_deck #Threat as stack
    @table = Array.new #Threat as stack
    @number_players = 0
    @user_turn_queue = init_turn_queue
    deal_cards
    init_table_played_cards
    puts "------------ Done Initializing --------------\n"
  end

  def init_deck
    new_deck = Array.new
    game_tables.each do |gamecard|
      card = Card.find(gamecard.card_id)
      new_deck.push(card)
      gamecard.assign_to_deck
    end
    new_deck.shuffle
    save
    reload
    new_deck
  end

  def deal_cards
    users.each do |user|
      puts "-------Dealing card to user: #{user.id} #{user.username} ##{user.email}"
      (0..6).each do |i|   #TODO: Find a way to test with the database
        card = @deck.pop
        gamecard = GameTable.find_by card_id: card.id
        puts "assigning gamecard: \" #{gamecard} \", To user id: #{user.id}"
        gamecard.assign_to_user(user.id)
        gamecard.save
        gamecard.reload
        puts "ASSIGNED gamecard to user id: #{user.id}. This is the game card after: #{gamecard}"
      end
    end
    save
    reload
  end

  def init_turn_queue
    queue = Array.new
    users.each do |user|
      queue.push(user)
    end
    @current_player = next_in_line(queue)
    queue
  end

  def next_turn
    @current_player = next_in_line(@user_turn_queue) # state of user_turn_queue correct? 
  end

  def skip_next_turn
    player_skipped = next_in_line(@user_turn_queue)
    @current_player = next_in_line(@user_turn_queue)
  end

  def init_table_played_cards
    card = @deck.pop
    if( action_card?(card) )
      @deck.push(card) # put it back
      init_table_played_cards
    elsif( wild_card?(card) )
      @deck.push(card) # put it back
      init_table_played_cards
    else
      @table.push( card )
      @current_card = @table.last # peek
    end
    save
    reload
  end

  def add_player(user) # Validation of user done with device, or do here?
    if can_accomodate(user)
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
      return user
    end
    false
  end

  def start

  end

  def end_game
  end

  def play_card(card, user)
    if ! user.eql? @current_player 
    # Validate user
      return false
    elsif ! validate_card(card)# Validate card 
      return false
    end
    
    # Do proper action if wild or action
    # One card left?
    # Add to played_table
    # Set current card
    # Set current color
    # Set current player
  end

  def validate_card(card)
    if card.color.eql? @current_card.color
      return true
    elsif card.value.eql? @current_card.value 
      return true
    elsif wild_card?(card)
      return true
    else#if the last card was wildcard

    end
    false
  end

  def can_accomodate(user)
    if(!(users.length <= MAX_NUMBER_PLAYERS))
      false
    else
      !has_user?(user)
    end
  end

  def has_user?(user)
    usernames = users.all.map(&:username)
    usernames.include?(user.username)
  end

  def action_card?(card)
    (10..12).cover?(card.value)
  end

  def wild_card?(card)
    (card.color.eql? "black") && (0..1).cover?(card.value)
  end

  def is_full?
    !(users.length <= MAX_NUMBER_PLAYERS)
  end

  def next_in_line(array)
    el = array.pop
    array.unshift(el)
    el 
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
# play_card(card, user)
# Need testing - next_turn
# Need testing - skip_turn
# reverse_turn
# draw_four(card, color)
# wild_draw_two(card)
# wild(card)
# get_cards(user) [all cards] if user validates/ false
