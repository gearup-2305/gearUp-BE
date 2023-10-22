require 'rails_helper'

RSpec.describe GearUpBeSchema, type: :graphql do
  it 'matches the dumped schema (rails graphql:schema:dump)' do
    aggregate_failures do
      expected = described_class.to_definition.gsub(/\s+/, ' ')
      actual = File.read(Rails.root.join('schema.graphql')).gsub(/\s+/, ' ')

      expect(expected).to eq(actual)
    end
  end
end
