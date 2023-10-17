module Mutations
  class UpdateDonation < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: true
    argument :email, String, required: true
    argument :amount, Float, required: true
    argument :post_id, Integer, required: true

    field :donation, Types::DonationType, null: true
    field :errors, [String], null: false

    def resolve(id:, name:, email:, amount:, post_id:)
      donation = Donation.find(id)

      if donation.update(
        name: name,
        email: email,
        amount: amount,
        post_id: post_id
      )
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