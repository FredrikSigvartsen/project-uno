class Card < ActiveRecord::Base
  # Attributes: :id, :value, :color, :created_at, :updated_at
  validates :value, presence: true
  validates :color, presence: true
  # Association
  has_many :game_tables
  has_many :games, through: :game_tables
end
