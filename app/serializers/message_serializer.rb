class MessageSerializer
  include JSONAPI::Serializer
  attributes :content
  has_many :links
end
