class GameUser < ActiveRecord::Base
  # Attributes: :id, :user_id, :game_id, :created_id, :updated_at

  # Association
  belongs_to :games
  belongs_to :users


end
