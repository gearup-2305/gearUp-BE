class WelcomeMailer < ApplicationMailer

  def donation_confirmation_email(user, donation)
    @user = user
    @donation = donation

    mail(to: user.email, subject: 'Donation Confirmation')
  end
end
