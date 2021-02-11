class LinkSerializer
  include JSONAPI::Serializer
  attributes :url
  belongs_to :message
end
