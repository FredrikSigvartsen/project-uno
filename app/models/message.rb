class Message < ActiveRecord::Base
  # Attributes: :id, :user_id, :message, :time, :created_at, :updated_at

  validates :user_id, presence: true
  validates :message, presence: true
  
  belongs_to :chat
end
