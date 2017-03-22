class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics
  has_many :bookmarks
  has_many :likes, dependent: :destroy

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }
  validates :username,
            presence: true

  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end
end
