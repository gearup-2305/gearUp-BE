# frozen_string_literal: true

module Types
  class DonationType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :email, String
    field :amount, Float
    field :post_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
