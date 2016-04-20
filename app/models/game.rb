class Game < ActiveRecord::Base
  # Attributes: :id, :host_id, :description, :updated_at, :created_at
  #has_many :users
  validates :host_id, presence: true

  # Association
  has_many :game_tables
  has_many :game_users
  has_many :users, through: :game_users
  has_many :cards, through: :game_tables
  has_one :chats

    def to_s
      "Game ID: #{id}, Host ID: #{host_id}\nDescription: #{description}"
    end
end
