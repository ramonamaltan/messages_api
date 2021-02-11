class MessageSerializer
  include JSONAPI::Serializer
  attributes :content, :counter
  has_many :links
  has_many :emails
end
