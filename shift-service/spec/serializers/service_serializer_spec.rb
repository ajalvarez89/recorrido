# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServiceSerializer, type: :serializer do
  let(:service) { services(:base) }
  subject(:serializer) do
    JSON.parse(described_class.new(service).to_json, symbolize_names: true)
  end

  it 'builds the attributes' do
    expect(serializer[:id]).to eq(service.id)
    expect(serializer[:name]).to eq(service.name)
    expect(serializer[:description]).to eq(service.description)
  end
end
