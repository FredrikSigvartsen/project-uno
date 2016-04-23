class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Attributes: :id, :username, :email, :encrypted_password, :avatar, :current_sign_in_ip, :sign_in_count, 
  # * :reset_password_token
  # Timestamps attributes: :created_at, :last_sign_in, :updated_at, :current_sign_in, :remember_created_at
  # *:reset_password_sent_at
  validates :email, presence: true, uniqueness: true
  has_many :messages
  

  def to_s
    "User ID: #{id}, Username: #{username}, Email: #{email}, Last signed in: #{last_sign_in_at.nil? ? "never signed in" : last_sign_in_at}"
  end
end
