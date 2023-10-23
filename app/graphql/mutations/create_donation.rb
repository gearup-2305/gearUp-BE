module Mutations
  class CreateDonation < BaseMutation
    argument :amount, Float, required: true
    argument :post_id, Integer, required: true
    argument :name, String, required: true
    argument :email, String, required: true

    field :donation, Types::DonationType, null: false
    field :errors, [String], null: false

    def resolve(amount:, post_id:, name:, email:)

      post = Post.find(post_id)
      donation = post.donations.create!(amount: amount, post_id: post_id, name: name, email: email)

      if donation.save
        post.update_current_amount
        
        WelcomeEmailWorker.perform_async(email, donation.id)

        {
          donation: donation,
          errors: []
        }
      else
        {
          donation: nil,
          errors: donation.errors.full_messages
        }
      end
    end
  end
end
