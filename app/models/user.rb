class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { in: 1..30 }
  validates :introduction, length: { maximum: 200 }

  has_many :teams, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :members_teams, through: :members, source: :team

  mount_uploader :image, ImageUploader

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.username = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.admin_guest
    find_or_create_by!(email: 'admin_guest@example.com') do |user|
      user.username = 'ゲスト管理者'
      user.password = SecureRandom.urlsafe_base64
      user.admin = 'true'
    end
  end
end
