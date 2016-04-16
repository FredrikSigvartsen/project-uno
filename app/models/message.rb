class Message < ActiveRecord::Base
  # Attributes: :id, :user_id, :message, :time, :created_at, :updated_at
  belongs_to :chat
end
