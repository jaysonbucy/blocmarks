class Bookmark < ApplicationRecord
  belongs_to :topic

  has_many :bookmarks
end
