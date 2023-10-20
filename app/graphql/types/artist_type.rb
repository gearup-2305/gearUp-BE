# frozen_string_literal: true

module Types
  class ArtistType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :email, String
    field :city, String
    field :state, String
    field :zipcode, String
    field :password_digest, String
    field :medium, String
    field :profile_image, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :posts, [Types::PostType], null: false do
      argument :orderBy, PostOrderEnum, required: false
    end

    def posts(orderBy: nil)
      posts = object.posts

      if orderBy == "ASC"
        posts = posts.order(created_at: :asc)
      elsif orderBy == "DESC"
        posts = posts.order(created_at: :desc)
      end

      posts
    end
  end
end