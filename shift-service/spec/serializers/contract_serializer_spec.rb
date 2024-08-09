# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContractSerializer, type: :serializer do
  let(:contract) { contracts(:base) }
  subject(:serializer) do
    JSON.parse(described_class.new(contract).to_json, symbolize_names: true)
  end

  it 'builds the attributes' do
    expect(serializer[:id]).to eq(contract.id)
    expect(serializer[:start_date]).to eq(contract.start_date.iso8601)
    expect(serializer[:end_date]).to eq(contract.end_date.iso8601)
    expect(serializer[:start_hour_weekday]).to eq(contract.start_hour_weekday)
    expect(serializer[:end_hour_weekday]).to eq(contract.end_hour_weekday)
    expect(serializer[:start_hour_weekend]).to eq(contract.start_hour_weekend)
    expect(serializer[:end_hour_weekend]).to eq(contract.end_hour_weekend)
    expect(serializer[:service_id]).to eq(contract.service_id)
  end
end
