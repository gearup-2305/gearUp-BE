require 'rails_helper'

RSpec.describe 'GraphQL Create Post', :vcr do
  before do
    Artist.create(
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

  describe 'mutation create post' do
    it 'creates a new post' do
      mutation = <<~GRAPHQL
        mutation {
          createPost(input: {
            title: "Test Title",
            details: "Test Details",
            imageUrl: "Test Image Url",
            requestedAmount: 100.00,
            currentAmount: 0.00,
            artistId: 1
          }) {
            post {
              id
              title
              details
              imageUrl
              requestedAmount
              currentAmount
            }
            errors
          }
        }
        GRAPHQL

      post "/graphql", params: { query: mutation }

      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
      expect(result).to have_key("data")

      expect(result["data"]).to have_key("createPost")
      expect(result["data"]["createPost"]).to be_a(Hash)

      expect(result["data"]["createPost"]).to have_key("post")
      expect(result["data"]["createPost"]["post"]).to be_a(Hash)

      expect(result["data"]["createPost"]["post"]).to have_key("id")
      expect(result["data"]["createPost"]["post"]).to have_key("title")

      expect(result["data"]["createPost"]["post"]).to have_key("details")
      expect(result["data"]["createPost"]["post"]).to have_key("imageUrl")

      expect(result["data"]["createPost"]["post"]).to have_key("requestedAmount")
      expect(result["data"]["createPost"]["post"]).to have_key("currentAmount")

      expect(result["errors"]).to be_nil
    end
  end
end