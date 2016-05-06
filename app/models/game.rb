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

  MAX_NUMBER_PLAYERS = 6

  def initialize
    puts "------------ Initializing Game #{id} with Host #{host_id} --------------\n"
    @deck = init_deck #Threat as stack
    @table = Array.new #Threat as stack
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
      gamecard.reload
      gamecard.save
    end
    new_deck.shuffle
    new_deck
  end

  def deal_cards
    users.each do |user|
      #(0..6).each do |i|   #TODO: Manage a way to read from database. 
      if( @deck.empty?)
        return false
      end
        card = @deck.pop
        gamecard = GameTable.find_by card_id: card.id
        gamecard.assign_to_user(user.id)
      #end
    end
  end

  def init_table_played_cards
    card = @deck.pop 
  
    if( action_card?(card) )
      @deck.push(card)
      init_table_played_cards
    elsif( wild_card?(card) )
      @deck.push(card)
      init_table_played_cards
    else
      @table.push( card )
    end
  end

  def add_player(user)
    
  end

  def can_accomodate(user)
    if(!(users.length <= MAX_NUMBER_PLAYERS))
      false
    else
      has_user?(user)
    end
  end

  def has_user?(user)
    usernames = users.all.map(:username)
    usernames.include?(user.username)
  end

  def action_card?(card)
    (10..12).cover?(card.value)
  end

  def wild_card?(card)
    (card.color.eql? "black") && (0..1).cover?(card.value)
  end

  def to_s
    "Game ID: #{id}, Host ID: #{host_id}\nDescription: #{description}"
  end
end
# Initialize a random deck of card
# Deal 7 cards to all the users.
# Initialize the table deck, with a random card from the deck. Remember, action/wild card is not allowed
