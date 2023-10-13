# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


30.times do 
  artist = Artist.create(
    name: Faker::Artist.name,
    email: Faker::Internet.email,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zipcode: Faker::Address.zip_code,
    password: 'password',
    medium: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
    profile_image: Faker::Avatar.image
  )

  num_posts = rand(0..10)

  num_posts.times do
    requested_amount = format('%.2f', rand(0.1..1000000.0))
    current_amount = format('%.2f', rand(0.1..requested_amount.to_f))

    artist.posts.create(
      title: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
      details: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
      image_url: Faker::Internet.url,
      requested_amount: requested_amount,
      current_amount: current_amount
    )
  end

  donation_amount = rand(0.1..1000)
    donations = artist.posts.each do |post|
      post.donations.create(
      name: Faker::Hipster.name,
      email: Faker::Internet.email,
      amount: donation_amount
    )
  end
end
