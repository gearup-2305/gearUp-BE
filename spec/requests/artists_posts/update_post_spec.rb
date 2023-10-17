require 'rails_helper'

RSpec.describe 'GraphQL Update Post', :vcr do
  before do
    @artist = Artist.create(
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

    @post = @artist.posts.create(
      id: 1,
      title: "title",
      details: "details",
      image_url: "internet.url",
      requested_amount: 1000,
      current_amount: 0
    )
  end

  describe "mutation update post" do
    it "updates a post" do
      expect(@post.title).to eq("title")
      expect(@post.details).to eq("details")
      expect(@post.image_url).to eq("internet.url")
      expect(@post.requested_amount).to eq(1000)
      expect(@post.current_amount).to eq(0)

      mutation = <<~GRAPHQL
        mutation UpdatePost {
          updatePost(input: {
            id: 1,
            title: "I need ",
            details: "Don't worry",
            imageUrl: "http://wiegand.test/jaye_reinger",
            requestedAmount: 3444.00,
            currentAmount: 0,
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
      expect(result["data"]).to have_key("updatePost")

      expect(result["data"]["updatePost"]).to have_key("post")
      expect(result["data"]["updatePost"]["post"]).to be_a(Hash)
      expect(result["data"]["updatePost"]["post"]).to have_key("id")
      expect(result["data"]["updatePost"]["post"]).to have_key("title")
      expect(result["data"]["updatePost"]["post"]).to have_key("details")
      expect(result["data"]["updatePost"]["post"]).to have_key("imageUrl")
      expect(result["data"]["updatePost"]["post"]).to have_key("requestedAmount")
      expect(result["data"]["updatePost"]["post"]).to have_key("currentAmount")

      expect(result["data"]["updatePost"]["post"]["id"]).to eq("1")
      expect(result["data"]["updatePost"]["post"]["title"]).to eq("I need ")
      expect(result["data"]["updatePost"]["post"]["details"]).to eq("Don't worry")
      expect(result["data"]["updatePost"]["post"]["imageUrl"]).to eq("http://wiegand.test/jaye_reinger")
      expect(result["data"]["updatePost"]["post"]["requestedAmount"]).to eq(3444.00)
      expect(result["data"]["updatePost"]["post"]["currentAmount"]).to eq(0)
    end

    # it "returns an error if post is not updated" do
    #   mutation = <<~GRAPHQL
    #     mutation UpdatePost {
    #       updatePost(input: {
    #         id: 1,
    #         title: "I need ",
    #         details: "Don't worry",
    #         imageUrl: "http://wiegand.test/jaye_reinger",
    #         requestedAmount: 3444.00,
    #         currentAmount: 0,
    #         artistId: 1
    #       }) {
    #         post {
    #           id
    #           title
    #           details
    #           imageUrl
    #           requestedAmount
    #           currentAmount
    #         }
    #         errors
    #       }
    #     }
    #     GRAPHQL
    # end
  end
end