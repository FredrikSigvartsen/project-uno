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
    self.user_id = user_id_assigned
    self.card_in_deck = false
    self.card_played = false
    self.save
    self.reload
  end

  def assign_to_deck
    self.card_in_deck = true
    self.user_id = 0
    self.card_played = false
    self.save
    self.reload
  end

  def assign_to_played_card
    self.card_played = true
    self.user_id = 0
    self.card_in_deck = false
    self.save
    self.reload 
  end

  def to_s #For testing purposes
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
