class Game < ActiveRecord::Base
  # Attributes: :id, :host_id, :description
  #has_many :users
  validates :id, presence: true, uniqueness: true
  validates :host_id, presence: true

  has_many()
    def to_s
      "Game ID: #{id}, Host ID: #{host_id}\nDescription: #{description}"
    end
end
