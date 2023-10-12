require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "relationships" do
    it { should have_many :posts }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
    it { should validate_presence_of :medium }
  end
end
