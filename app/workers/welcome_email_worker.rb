class WelcomeEmailWorker
  include Sidekiq::Worker

  def perform(email, donation_id)
    user = Artist.find_by(email: email)
    donation = Donation.find(donation_id)
    WelcomeMailer.donation_confirmation_email(user, donation).deliver_now
  end
end
