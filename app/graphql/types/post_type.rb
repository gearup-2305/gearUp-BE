# frozen_string_literal: true

module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :details, String
    field :image_url, String
    field :requested_amount, Float
    field :current_amount, Float
    field :artist_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :donations, [Types::DonationType], null: false

    def donations
      object.donations
    end
  end
end
