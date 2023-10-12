# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


5.times do
  artist = Artist.create(
    name: Faker::Artist.name,
    email: Faker::Internet.email,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zipcode: Faker::Address.zip_code,
    password: 'password'
    medium: Faker::Lorem.word,
    profile_image: Faker::Avatar.image
  )

  5.times do
    artist.posts.create(
      title: Faker::Lorem.sentence,
      details: Faker::Lorem.paragraph,
      image_url: Faker::Internet.url,
      requested_amount: Faker::Number.decimal(l_digits: 2),
      current_amount: Faker::Number.decimal(l_digits: 2)
    )
  end
end