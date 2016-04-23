class Message < ActiveRecord::Base
  # Attributes: :id, :user_id, :chat_id, :message, :time, :created_at, :updated_at

<<<<<<< HEAD
  # validates :user_id, presence: true
  # validates :message, presence: true
  
  # belongs_to :chat
=======
  validates :user_id, presence: true
  validates :chat_id, presence: true
  validates :message, presence: true
  
  belongs_to :chat
  belongs_to :user
  
  def initialize
    
  end

  def to_s
    user = User.find(user_id)
    "#{user.username} wrote something at: #{time}:\n#{message} "
  end
>>>>>>> 89cb275983c9791ea1e8eaa3d668c0a430343e45
end
