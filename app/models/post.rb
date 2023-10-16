class Post < ApplicationRecord
  belongs_to :artist
  has_many :donations
  
  
  validates_presence_of :title, 
                        :details, 
                        :image_url, 
                        :requested_amount, 
                        :current_amount
end
