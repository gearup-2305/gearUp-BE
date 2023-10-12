class Artist < ApplicationRecord
  has_many :posts

  has_secure_password

  validates_presence_of :name, :email, :city, :state, :zipcode, :medium
end
