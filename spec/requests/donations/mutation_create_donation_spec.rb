require 'rails_helper'

RSpec.describe 'GraphQL Create Donation', :vcr do
  before do
    @artist = Artist.create(
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
      title: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
      details: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
      image_url: Faker::Internet.url,
      requested_amount: 1000,
      current_amount: 0
    )
  end

  describe "mutation create donation" do
    it "creates a new donation" do
      mutation = <<~GRAPHQL
        mutation CreateDonation {
          createDonation(input: {
            name: "donation"
            email: "email@gmail.com"
            postId: 1
            amount: 50.0
          }) {
            donation {
              id
              amount
            }
            errors
          }
        }
        GRAPHQL

      post "/graphql", params: { query: mutation }

      result = JSON.parse(response.body)

      expect(result).to be_a(Hash)
      expect(result).to have_key("data")

      expect(result["data"]).to have_key("createDonation")
      expect(result["data"]["createDonation"]).to be_a(Hash)

      expect(result["data"]["createDonation"]).to have_key("donation")
      expect(result["data"]["createDonation"]["donation"]).to be_a(Hash)

      expect(result["data"]["createDonation"]["donation"]).to have_key("id")
      expect(result["data"]["createDonation"]["donation"]).to have_key("amount")

      expect(result["data"]["createDonation"]["donation"]["amount"]).to eq(50.0)
      expect(result["data"]["createDonation"]["errors"]).to eq([])

      expect(Donation.last.amount).to eq(50.0)
      expect(Donation.last.post_id).to eq(1)

      expect(Donation.last.name).to eq("donation")
      expect(Donation.last.email).to eq("email@gmail.com")

      expect(Donation.last.post.current_amount).to eq(50.0)
      expect(WelcomeEmailWorker.jobs.size).to eq(1)
    end

    it "returns an error if donation is not created" do
      mutation = <<~GRAPHQL
        mutation CreateDonation {
          createDonation(input: {
            email: "email@gmail.com"
            postId: 1
          }) {
            donation {
              id
              amount
            }
            errors
          }
        }
        GRAPHQL

      post "/graphql", params: { query: mutation }
      result = JSON.parse(response.body)
      expect(result["errors"][0]["message"]).to eq("Argument 'amount' on InputObject 'CreateDonationInput' is required. Expected type Float!")
    end
  end
end