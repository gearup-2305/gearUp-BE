# spec/mailers/welcome_mailer_spec.rb

require 'rails_helper'

RSpec.describe WelcomeMailer, type: :mailer do
  describe 'donation_confirmation_email' do
    it 'renders the subject' do
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

      donation = Donation.create(
        name: 'Sample Name',
        email: 'donor@example.com',
        amount: 100.0,
        post_id: 1
      )

      mail = WelcomeMailer.donation_confirmation_email(artist, donation)

      expect(mail.subject).to eq('Donation Confirmation')
    end

    it 'renders the receiver email' do
      artist = Artist.create(
        name: 'Jane Smith',
        email: 'jane@example.com',
        city: 'Sample City',
        state: 'Sample State',
        zipcode: '12345',
        password_digest: 'sample_password_digest',
        medium: 'Sample Medium',
        profile_image: 'sample_profile_image.jpg'
      )

      donation = Donation.create(
        name: 'Sample Name',
        email: 'donor@example.com',
        amount: 200.0,
        post_id: 2
      )

      mail = WelcomeMailer.donation_confirmation_email(artist, donation)

      expect(mail.to).to eq([artist.email])
    end

    it 'renders the sender email' do
      artist = Artist.create(
        name: 'Alice Johnson',
        email: 'alice@example.com',
        city: 'Sample City',
        state: 'Sample State',
        zipcode: '12345',
        password_digest: 'sample_password_digest',
        medium: 'Sample Medium',
        profile_image: 'sample_profile_image.jpg'
      )

      donation = Donation.create(
        name: 'Sample Name',
        email: 'donor@example.com',
        amount: 300.0,
        post_id: 3
      )

      mail = WelcomeMailer.donation_confirmation_email(artist, donation)

      expect(mail.from).to eq(["from@example.com"]) # Make an email for our app and add it here
    end

    it 'assigns artist' do
      artist = Artist.create(
        name: 'Bob Brown',
        email: 'bob@example.com',
        city: 'Sample City',
        state: 'Sample State',
        zipcode: '12345',
        password_digest: 'sample_password_digest',
        medium: 'Sample Medium',
        profile_image: 'sample_profile_image.jpg'
      )

      donation = Donation.create(
        name: 'Sample Name',
        email: 'donor@example.com',
        amount: 400.0,
        post_id: 4
      )

      mail = WelcomeMailer.donation_confirmation_email(artist, donation)

      expect(mail.body.encoded).to match(artist.name)
    end

    it 'assigns donation' do
      artist = Artist.create(
        name: 'Charlie Davis',
        email: 'charlie@example.com',
        city: 'Sample City',
        state: 'Sample State',
        zipcode: '12345',
        password_digest: 'sample_password_digest',
        medium: 'Sample Medium',
        profile_image: 'sample_profile_image.jpg'
      )

      donation = Donation.create(
        name: 'Sample Name',
        email: 'donor@example.com',
        amount: 500.0,
        post_id: 5
      )

      mail = WelcomeMailer.donation_confirmation_email(artist, donation)

      expect(mail.body.encoded).to match(donation.amount.to_s)
      expect(mail.body.encoded).to match(donation.post_id.to_s)
    end
  end
end
