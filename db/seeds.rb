# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
painter = Artist.create!(
  name: "Bob Ross",
  email: "example@gamil.com",
  city: "Orlando",
  state: "FL",
  zipcode: 32156,
  password: "password",
  medium: "Oil",
  profile_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Bob_Ross%2C_c._1983.jpg/440px-Bob_Ross%2C_c._1983.jpg"
)

# Posts
painter.posts.create!(
  title: "Happy Little Trees",
  details: "I like to paint happy little trees",
  image_url: "https://i.pinimg.com/originals/0f/6e/9a/0f6e9a3b2b2b5b0b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2.jpg",
  requested_amount: 100.0,
  current_amount: 0,
  artist_id: painter.id
)
