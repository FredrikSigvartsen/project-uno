class Chat < ActiveRecord::Base
  #Attributes: :id, :game_id, :created_at, :updated_at
  validates :game_id, presence: true

  has_many :messages
  belongs_to :games

  def to_s # for testing purposes
    str = "Chat belongs to game id: #{game_id}\n"
    self.messages.each do |message|
      str += "#{message}\n"
    end
    str
  end
end