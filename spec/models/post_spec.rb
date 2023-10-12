require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "relationships" do
    it { should belong_to :artist }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :details }
    it { should validate_presence_of :image_url }
    it { should validate_presence_of :requested_amount }
    it { should validate_presence_of :current_amount }
  end
end
