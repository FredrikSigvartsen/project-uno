class Message < ActiveRecord::Base
  include ActiveModel::Model
  attr_accessor :name,:message,:timestamp

  # Attributes: :id, :user_id, :chat_id, :message, :time, :created_at, :updated_at
  # validates :user_id, presence: true
  # validates :chat_id, presence: true
  # validates :message, presence: true
  
  belongs_to :chat
  belongs_to :user
  
  # def initialize
    
  # end

  def to_s
    user = User.find(user_id)
    "#{user.username} wrote something at: #{time}:\n#{message} "
  end
end
