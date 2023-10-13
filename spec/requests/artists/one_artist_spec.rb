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
    end

    it "returns a single artist with selected attributes" do
      query = <<~GRAPHQL
        query {
          artist(id: 1) {
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
      expect(result["data"]).to have_key("artist")
      expect(result["data"]["artist"]).to be_a(Hash)
      expect(result["data"]["artist"]).to have_key("name")
      expect(result["data"]["artist"]).to have_key("email")
      expect(result["data"]["artist"]).to have_key("zipcode")

      # Does not return attributes that are not selected
      expect(result["data"]["artist"]).to_not have_key("city")
      expect(result["data"]["artist"]).to_not have_key("createdAt")
      expect(result["data"]["artist"]).to_not have_key("id")
      expect(result["data"]["artist"]).to_not have_key("medium")
      expect(result["data"]["artist"]).to_not have_key("passwordDigest")
      expect(result["data"]["artist"]).to_not have_key("profileImage")
      expect(result["data"]["artist"]).to_not have_key("state")
      expect(result["data"]["artist"]).to_not have_key("updatedAt")
    end
  end
end