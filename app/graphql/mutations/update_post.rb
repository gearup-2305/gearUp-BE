module Mutations
  class UpdatePost < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: true
    argument :details, String, required: true
    argument :image_url, String, required: true
    argument :requested_amount, Float, required: true
    argument :current_amount, Float, required: true
    argument :artist_id, Integer, required: true

    field :post, Types::PostType, null: false
    field :errors, [String], null: false

    def resolve(id:, title:, details:, image_url:, requested_amount:, current_amount:, artist_id:)
      post = Post.find(id)
      
      if post.update(
        title: title,
        details: details,
        image_url: image_url,
        requested_amount: requested_amount,
        current_amount: current_amount,
        artist_id: artist_id
      )
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