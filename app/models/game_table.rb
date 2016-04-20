class GameTable < ActiveRecord::Base
  # Attributes: :id, :game_id, :card_id, :user_id, :card_in_deck
  # * :card_played, :created_at, :updated_at
  validates :game_id, presence: true
  validates :card_id, presence: true
  after_initialize :default_values
  #Association
  belongs_to :games
  has_one :cards

  def default_values
    card_id = nil
    card_in_deck = false;
    card_played = false;
  end

  def to_s #For testing purposes
    place = "something is wrong"
    if(!(user_id.nil?))
      place = "User #{user_id} has it"
    elsif( card_in_deck)
      place = "Card in deck"
    elsif( card_played)
      place = "Card played"
    end
    "Game: #{game_id}, Card: #{card_id}, Where is the card: #{place}"
  end

end
