puts 'deleting old data'
Link.delete_all
Email.delete_all
Message.delete_all

2.times do
  Message.create(content: Faker::Quote.yoda, counter: 0)
end

2.times do
  Link.create(url: Faker::Internet.url, message_id: Message.first.id)
end

2.times do
  Link.create(url: Faker::Internet.url, message_id: Message.last.id)
end

2.times do
  Email.create(email_address: Faker::Internet.email, message_id: Message.last.id)
end

2.times do
  Email.create(email_address: Faker::Internet.email, message_id: Message.first.id)
end

puts "Created #{Link.count} links, #{Email.count} emails and #{Message.count} messages"
