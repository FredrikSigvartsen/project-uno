class Game < ActiveRecord::Base
  # Attributes: :id, :host_id, :description
  #has_many :users
  validates :id, presence: true, uniqueness: true
  validates :host_id, presence: true

  # Association
  has_many :game_tables
  has_many :users, through: :game_tables
    def to_s
      "Game ID: #{id}, Host ID: #{host_id}\nDescription: #{description}"
    end
end
