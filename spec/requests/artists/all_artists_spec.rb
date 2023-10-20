require 'rails_helper'

RSpec.describe 'GraphQL ALL Artists', :vcr do
  before do
    5.times do
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
  end

  describe 'query all artists' do
    it 'returns a list of all artists with all attributes' do
      query = <<~GRAPHQL
        query {
          artists {
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
            }
          }
        GRAPHQL

      post "/graphql", params: { query: query }

      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
      expect(result).to have_key("data")

      expect(result["data"]).to have_key("artists")
      expect(result["data"]["artists"]).to be_an(Array)

      expect(result["data"]["artists"][0]).to have_key("city")
      expect(result["data"]["artists"][0]).to have_key("createdAt")
      expect(result["data"]["artists"][0]).to have_key("email")
      expect(result["data"]["artists"][0]).to have_key("id")
      expect(result["data"]["artists"][0]).to have_key("medium")
      expect(result["data"]["artists"][0]).to have_key("name")
      expect(result["data"]["artists"][0]).to have_key("passwordDigest")
      expect(result["data"]["artists"][0]).to have_key("profileImage")
      expect(result["data"]["artists"][0]).to have_key("state")
      expect(result["data"]["artists"][0]).to have_key("updatedAt")
      expect(result["data"]["artists"][0]).to have_key("zipcode")
    end

    it "returns a list of all artists with selected attributes" do
      query = <<~GRAPHQL
        query {
          artists {
              name
              email
              zipcode
            }
          }
        GRAPHQL

      post "/graphql", params: { query: query }

      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
      expect(result).to have_key("data")
      expect(result["data"]).to have_key("artists")
      expect(result["data"]["artists"]).to be_an(Array)
      expect(result["data"]["artists"][0]).to have_key("name")
      expect(result["data"]["artists"][0]).to have_key("email")
      expect(result["data"]["artists"][0]).to have_key("zipcode")

      # Does not return attributes that are not selected
      expect(result["data"]["artists"][0]).to_not have_key("city")
      expect(result["data"]["artists"][0]).to_not have_key("createdAt")
      expect(result["data"]["artists"][0]).to_not have_key("id")
      expect(result["data"]["artists"][0]).to_not have_key("medium")
      expect(result["data"]["artists"][0]).to_not have_key("passwordDigest")
      expect(result["data"]["artists"][0]).to_not have_key("profileImage")
      expect(result["data"]["artists"][0]).to_not have_key("state")
      expect(result["data"]["artists"][0]).to_not have_key("updatedAt")
    end

    it "has posts that can be sorted by ASC or DESC" do
      query = <<~GRAPHQL
        query {
          artists {
              name
              posts(orderBy: DESC) {
                id
              }
            }
          }
        GRAPHQL

      post "/graphql", params: { query: query }

      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
      expect(result).to have_key("data")

      expect(result["data"]).to have_key("artists")
      expect(result["data"]["artists"]).to be_an(Array)

      expect(result["data"]["artists"][0]).to have_key("name")
      expect(result["data"]["artists"][0]).to have_key("posts")
      expect(result["data"]["artists"][0]["posts"]).to be_an(Array)

      expect(result["data"]["artists"][0]["posts"][0]).to have_key("id")
      first_post_id = result["data"]["artists"][0]["posts"][0]["id"].to_i
      second_post_id = result["data"]["artists"][0]["posts"][1]["id"].to_i
      
      expect(first_post_id).to be > second_post_id
    end
  end
end