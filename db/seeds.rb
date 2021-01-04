Participation.destroy_all
Event.destroy_all
User.destroy_all

Participation.destroy_all
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
    description: Faker::Lorem.sentence(10),
    location: Faker::TvShows::Friends.location,
    start_date: Faker::Date.forward(days: 30),
    duration: rand(4..60)*5,
    administrator: User.all.sample,
    price: rand(50..1000)
  )
  e.participants.concat(User.all.sample(4))
end
puts "#{Event.all.count} events created"
puts "End of seeds"