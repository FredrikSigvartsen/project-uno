class GameTable < ActiveRecord::Base
  # Attributes: :id, :game_id, :card_id, :user_id, :card_in_deck
  # * :card_played, :created_at, :updated_at
  validates :game_id, presence: true
  validates :card_id, presence: true
  #Association
  belongs_to :games
  belongs_to :cards
end
