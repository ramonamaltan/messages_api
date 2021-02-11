class Message < ApplicationRecord
  validates :content, format: { with: /\p{L}+/ }
  validates :content, format: { without: /<[^>]*>/ }
  validates :content, length: { maximum: 255 }
end
