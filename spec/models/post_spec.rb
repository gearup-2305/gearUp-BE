require 'rails_helper'

RSpec.describe Post, type: :model do
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
      title: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
      details: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
      image_url: Faker::Internet.url,
      requested_amount: 1000,
      current_amount: 0
    )

  end

  describe "relationships" do
    it { should belong_to :artist }
    it { should have_many :donations }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :details }
    it { should validate_presence_of :image_url }
    it { should validate_presence_of :requested_amount }
    it { should validate_presence_of :current_amount }
  end

  describe "instance methods" do
    describe "update_current_amount" do
      it "updates the current amount of the post" do
        expect(@post.current_amount).to eq(0)

        donations = @post.donations.create(
            name: Faker::Hipster.words(number: 1),
            email: Faker::Internet.email,
            amount: 200
          )

        @post.update_current_amount
        expect(@post.current_amount).to eq(200)
      end
    end

    describe "donation_percentage" do
      it "returns the percentage of the requested amount that has been donated" do
        expect(@post.donation_percentage).to eq(0)

        donations = @post.donations.create(
            name: Faker::Hipster.words(number: 1),
            email: Faker::Internet.email,
            amount: 200
          )

        @post.update_current_amount
        expect(@post.donation_percentage).to eq(20)
      end
    end
  end
end 