require 'rails_helper'

RSpec.describe 'GraphQL Update Donation', :vcr do
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

    @donation = @post.donations.create(
      id: 1,
      name: Faker::Hipster.name,
      email: Faker::Internet.email,
      post_id: 1,
      amount: 100
    )
  end

  describe "mutation update donation" do
    it "updates a donation" do
      expect(@donation.amount).to eq(100)

      mutation = <<~GRAPHQL
      mutation UpdateDonation {
        updateDonation(input: {
          id: 1,
          name: "sally",
          email: "email@gmail.com",
          amount: 500,
          postId: 1
        }) {
          donation {
            id
            name
            email
            postId
          }
          errors
        }
      }
      GRAPHQL

      post "/graphql", params: { query: mutation }
      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
      expect(result).to have_key("data")

      expect(result["data"]).to have_key("updateDonation")
      expect(result["data"]["updateDonation"]).to be_a(Hash)

      expect(result["data"]["updateDonation"]).to have_key("donation")
      expect(result["data"]["updateDonation"]["donation"]).to be_a(Hash)

      expect(result["data"]["updateDonation"]["donation"]).to have_key("id")
      expect(result["data"]["updateDonation"]["donation"]).to have_key("name")

      expect(result["data"]["updateDonation"]["donation"]).to have_key("email")
      expect(result["data"]["updateDonation"]["donation"]).to have_key("postId")

      expect(result["data"]["updateDonation"]["donation"]["id"]).to eq("1")
      expect(result["data"]["updateDonation"]["donation"]["name"]).to eq("sally")
      expect(result["data"]["updateDonation"]["donation"]["email"]).to eq("email@gmail.com")

      expect(result["data"]["updateDonation"]["donation"]["postId"]).to eq(1)
      expect(result["data"]["updateDonation"]["errors"]).to eq([])
      
      expect(@donation.reload.amount).to eq(500)
    end

    it "returns an error if the donation is not found" do
      mutation = <<~GRAPHQL
        mutation UpdateDonation {
          updateDonation(input: {
            name: "sally",
          }) {
            donation {
              id
              name
              email
              postId
            }
            errors
          }
        }
        GRAPHQL

      post "/graphql", params: { query: mutation }
      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
      expect(result).to have_key("errors")

      expect(result["errors"]).to be_a(Array)
      expect(result["errors"][0]["message"]).to eq("Argument 'id' on InputObject 'UpdateDonationInput' is required. Expected type ID!")
    end
  end
end