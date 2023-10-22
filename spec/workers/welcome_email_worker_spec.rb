require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe WelcomeEmailWorker, type: :worker do
  it 'sends a donation confirmation email' do
    artist = Artist.create(
      name: 'John Doe',
      email: 'john@example.com',
      city: 'Sample City',
      state: 'Sample State',
      zipcode: '12345',
      password_digest: 'sample_password_digest',
      medium: 'Sample Medium',
      profile_image: 'sample_profile_image.jpg'
    )

    post = Post.create(
      id: 1,
      title: 'Sample Post',
      details: 'Sample details',
      image_url: 'sample_image.jpg',
      requested_amount: 1000.0,
      current_amount: 0.0,
      artist_id: artist.id
    )

    donation = post.donations.create(
      id: 1,
      name: 'Sample Name',
      email: 'donor@example.com',
      amount: 100.0,
      post_id: 1
    )

    ActionMailer::Base.deliveries.clear

    WelcomeEmailWorker.new.perform(artist.email, donation.id)

    expect(ActionMailer::Base.deliveries.count).to eq(1)

    last_email = ActionMailer::Base.deliveries.last

    expect(last_email.subject).to eq('Donation Confirmation')
    expect(last_email.to).to eq([artist.email])
    expect(last_email.body).to include("Thank you for your donation!")
    expect(last_email.body).to include("Dear John Doe,")
    expect(last_email.body).to include("We have received your donation of $$100.00 for post ID 1")
  end
end
