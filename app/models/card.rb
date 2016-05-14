class Card < ActiveRecord::Base
  # Attributes: :id, :value, :color, :created_at, :updated_at
  validates :value, presence: true
  validates :color, presence: true

  def to_s
    "Card #{id}, value: #{value}, color: #{color}"
  end
end
