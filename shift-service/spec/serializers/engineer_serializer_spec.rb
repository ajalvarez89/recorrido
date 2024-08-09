# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EngineerSerializer, type: :serializer do
  let(:engineer) { engineers(:base) }
  subject(:serializer) do
    JSON.parse(described_class.new(engineer).to_json, symbolize_names: true)
  end

  it 'builds the attributes' do
    expect(serializer[:id]).to eq(engineer.id)
    expect(serializer[:name]).to eq(engineer.name)
  end
end
