class EmailSerializer
  include JSONAPI::Serializer
  attributes :email_address
  belongs_to :message
end
