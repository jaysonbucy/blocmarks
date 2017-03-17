class Topic < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  validates :title,
            presence: true,
            length: { minimum: 2, maximum: 1024 }
end
