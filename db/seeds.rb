Participation.destroy_all
Comment.destroy_all
Event.destroy_all
User.destroy_all

Participation.destroy_all
Comment.reset_pk_sequence
Event.reset_pk_sequence
User.reset_pk_sequence

20.times do
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	user = User.create!(
		username: "username#{rand(1..1000)}",
		first_name: first_name,
		last_name: last_name,
		email: first_name + last_name + "@yopmail.com",
		password: "azerty",
    description: Faker::Lorem.paragraph(2, false, 4),
	)
end
puts "#{User.all.count} users created"

### Event seed ###
10.times do |i|
  e = Event.create!(
    title: "Event #{i+1}",
    description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    location: Faker::TvShows::Friends.location,
    start_date: Faker::Date.forward(days: 30),
    duration: rand(4..60)*5,
    administrator: User.all.sample,
    price: rand(50..1000)
  )
  e.participants.concat(User.all.sample(4))
end
puts "#{Event.all.count} events created"

#Create comments on Events
40.times do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
    commenter: User.all.sample,
    commentable: Event.all.sample,
  )
end

#Create comments on Comments
20.times do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
    commenter: User.all.sample,
    commentable: Comment.all.sample,
  )
end
puts "#{Comment.count} comments created"

puts "End of seeds"