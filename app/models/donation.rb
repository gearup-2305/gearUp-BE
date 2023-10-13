class Donation < ApplicationRecord
  belongs_to :post
  validates_presence_of :amount, :name, :email
end