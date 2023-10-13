require 'rails_helper'

RSpec.describe Donation, type: :model do
  describe "relationships" do
    it { should belong_to :post }
  end

  describe "validations" do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
  end
end