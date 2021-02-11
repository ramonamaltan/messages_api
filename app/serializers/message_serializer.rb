class MessageSerializer
  include JSONAPI::Serializer
  attributes :content, :counter
  has_many :links
  has_many :emails

  cache_options store: Rails.cache, namespace: 'jsonapiserializer', expires_in: 1.hour
end
