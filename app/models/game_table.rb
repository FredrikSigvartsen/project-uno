class GameTable < ActiveRecord::Base
  # Attributes: :id, :game_id, :card_id, :user_id, :card_in_deck
  # * :card_played, :created_at, :updated_at
  #validates :game_id, presence: true
  #validates :card_id, presence: true
  #after_initialize :default_values
  #Association
  belongs_to :games
  #has_one :card

  def assign_to_user(user_id_assigned)
    user_id = user_id_assigned
    card_in_deck = false
    card_played = false
    save
    reload
  end

  def assign_to_deck
    card_in_deck = true
    user_id = 0
    card_played = false
    save
    reload
  end

  def assign_to_played_card
    card_played = true
    user_id = 0
    card_in_deck = false
    save
    reload 
  end

  def to_s #For testing purposes
    self.reload
    place = "something is wrong"
    if( !(user_id.nil?) && user_id != 0)
      place = "User #{user_id} has it"
    elsif( card_in_deck)
      place = "Card in deck"
    elsif( card_played)
      place = "Card played"
    end
    "Game: #{game_id}, Card: #{card_id}, Where is the card: #{place}"
  end
end

# Status
