class Post < ApplicationRecord
  belongs_to :artist

  validates_presence_of :title, :details, :image_url, :requested_amount, :current_amount

  enum category: { request: 0, offer: 1 }
end
