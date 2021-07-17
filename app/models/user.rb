class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { in: 1..30 }
  validates :introduction, length: { maximum: 200 }

  has_many :teams

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.username = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
