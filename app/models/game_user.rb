class GameUser < ActiveRecord::Base
  # Attributes: :id, :user_id, :game_id, :created_id, :updated_at
  validates :user_id, presence: true
  validates :game_id, presence: true
  # Association
  belongs_to :games
  belongs_to :users


end
