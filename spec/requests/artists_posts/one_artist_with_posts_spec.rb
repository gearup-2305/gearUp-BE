require 'rails_helper'

RSpec.describe 'GraphQL One Artist', :vcr do
  before do
    artist = Artist.create(
      id: 1,
      name: Faker::Artist.name,
      email: Faker::Internet.email,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zipcode: Faker::Address.zip_code,
      password: 'password',
      medium: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
      profile_image: Faker::Avatar.image
    )
  
    5.times do
      artist.posts.create(
        title: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
        details: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
        image_url: Faker::Internet.url,
        requested_amount: Faker::Number.decimal(l_digits: 2),
        current_amount: Faker::Number.decimal(l_digits: 2)
      )
    end
  end

  describe 'query one artist by id' do
    it 'returns a single artist with all attributes' do
      query = <<~GRAPHQL
        query {
          artist(id: 1) {
              city
              createdAt
              email
              id
              medium
              name
              passwordDigest
              profileImage
              state
              updatedAt
              zipcode
              posts {
                id
                title
                details
                imageUrl
                requestedAmount
                currentAmount
                artistId
              }
            }
          }
        GRAPHQL

      post "/graphql", params: { query: query }

      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
      expect(result).to have_key("data")
      
      expect(result["data"]).to have_key("artist")
      expect(result["data"]["artist"]).to be_a(Hash)
      
      expect(result["data"]["artist"]).to have_key("city")
      expect(result["data"]["artist"]).to have_key("createdAt")

      expect(result["data"]["artist"]).to have_key("email")
      expect(result["data"]["artist"]).to have_key("id")

      expect(result["data"]["artist"]).to have_key("medium")
      expect(result["data"]["artist"]).to have_key("name")

      expect(result["data"]["artist"]).to have_key("passwordDigest")
      expect(result["data"]["artist"]).to have_key("profileImage")

      expect(result["data"]["artist"]).to have_key("state")
      expect(result["data"]["artist"]).to have_key("updatedAt")
      expect(result["data"]["artist"]).to have_key("zipcode")
      
      expect(result["data"]["artist"]).to have_key("posts")
      expect(result["data"]["artist"]["posts"]).to be_an(Array)
      expect(result["data"]["artist"]["posts"].count).to eq(5)

      expect(result["data"]["artist"]["posts"][0]).to have_key("id")
      expect(result["data"]["artist"]["posts"][0]).to have_key("title")

      expect(result["data"]["artist"]["posts"][0]).to have_key("details")
      expect(result["data"]["artist"]["posts"][0]).to have_key("imageUrl")

      expect(result["data"]["artist"]["posts"][0]).to have_key("requestedAmount")
      expect(result["data"]["artist"]["posts"][0]).to have_key("currentAmount")
      expect(result["data"]["artist"]["posts"][0]).to have_key("artistId")
    end

    it "returns a single artist with selected attributes" do
      query = <<~GRAPHQL
        query {
          artist(id: 1) {
              name
              email
              posts {
                title
              }
            }
          }
        GRAPHQL

      post "/graphql", params: { query: query }

      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
      expect(result).to have_key("data")

      expect(result["data"]).to have_key("artist")
      expect(result["data"]["artist"]).to be_a(Hash)
      
      expect(result["data"]["artist"]).to have_key("name")
      expect(result["data"]["artist"]).to have_key("email")
      
      expect(result["data"]["artist"]).to have_key("posts")
      expect(result["data"]["artist"]["posts"]).to be_an(Array)
      expect(result["data"]["artist"]["posts"].count).to eq(5)

      expect(result["data"]["artist"]["posts"][0]).to have_key("title")

      # Does not return attributes that are not selected
      expect(result["data"]["artist"]).to_not have_key("city")
      expect(result["data"]["artist"]).to_not have_key("createdAt")

      expect(result["data"]["artist"]).to_not have_key("id")
      expect(result["data"]["artist"]).to_not have_key("medium")

      expect(result["data"]["artist"]).to_not have_key("passwordDigest")
      expect(result["data"]["artist"]).to_not have_key("profileImage")

      expect(result["data"]["artist"]).to_not have_key("state")
      expect(result["data"]["artist"]).to_not have_key("updatedAt")
      expect(result["data"]["artist"]).to_not have_key("zipcode")
      
      expect(result["data"]["artist"]["posts"][0]).to_not have_key("id")
      expect(result["data"]["artist"]["posts"][0]).to_not have_key("details")

      expect(result["data"]["artist"]["posts"][0]).to_not have_key("imageUrl")
      expect(result["data"]["artist"]["posts"][0]).to_not have_key("requestedAmount")
      
      expect(result["data"]["artist"]["posts"][0]).to_not have_key("currentAmount")
      expect(result["data"]["artist"]["posts"][0]).to_not have_key("artistId")
    end
  end
end