class Message < ApplicationRecord
  has_many :links, dependent: :destroy
  has_many :emails, dependent: :destroy

  validates :content, presence: true
  validates :content, format: { with: /\p{L}+/ }
  validates :content, format: { without: /<[^>]*>/ }
  validates :content, length: { maximum: 255 }
end
