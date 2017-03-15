class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }
  validates :username,
            presence: true
end
