class Chat < ActiveRecord::Base
  #Attributes: :id, :game_id, :message_id, :created_at, :updated_at
  validates :game_id, presence: true
  validates :message_id, presence: true

  has_many :messages
  belongs_to :games
end
