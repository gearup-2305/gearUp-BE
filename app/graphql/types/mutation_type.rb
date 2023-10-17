# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_post, mutation: Mutations::CreatePost
    field :create_donation, mutation: Mutations::CreateDonation
    field :update_post, mutation: Mutations::UpdatePost
    field :update_donation, mutation: Mutations::UpdateDonation
  end
end
