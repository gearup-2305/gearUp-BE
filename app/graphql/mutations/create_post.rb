module Mutations
  class CreatePost < BaseMutation
    argument :title, String, required: true
    argument :details, String, required: true
    argument :image_url, String, required: true
    argument :requested_amount, Float, required: true
    argument :current_amount, Float, required: true
    argument :artist_id, Integer, required: true

    field :post, Types::PostType, null: false
    field :errors, [String], null: false

    def resolve(title:, details:, image_url:, requested_amount:, current_amount:, artist_id:)
      artist = Artist.find(artist_id)
      post = artist.posts.new(title: title, details: details, image_url: image_url, requested_amount: requested_amount, current_amount: current_amount, artist_id: artist_id)
      
      if post.save
        {
          post: post,
          errors: []
        }
      else
        {
          post: nil,
          errors: post.errors.full_messages
        }
      end
    end
  end
end













