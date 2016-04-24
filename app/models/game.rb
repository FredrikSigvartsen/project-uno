class Game < ActiveRecord::Base
  # Attributes: :id, :host_id, :description, :updated_at, :created_at
  #has_many :users
  validates :host_id, presence: true

  # Association
  has_many :game_tables
  has_one :chats
  has_many :game_users
  has_many :users, through: :game_users
  has_many :cards, through: :game_tables

  def initialize
    @deck = init_deck #Threat as stack
    @table = Array.new #Threat as stack
    @current_user = self.users.first
  end

  def init_deck #Must randomize
    new_deck = Array.new
    self.game_tables.each do |gamecard|
      new_deck.push(gamecard.card)
      gamecard.card_in_deck = true
    end
    new_deck.shuffle
  end

  def to_s
    "Game ID: #{id}, Host ID: #{host_id}\nDescription: #{description}"
  end
end
