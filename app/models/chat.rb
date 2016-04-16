class Chat < ActiveRecord::Base
  #Attributes: :id, :game_id, :message_id, :created_at, :updated_at

  has_many :messages
  belongs_to :games
end
