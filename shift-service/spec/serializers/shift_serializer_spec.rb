# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShiftSerializer, type: :serializer do
  let(:shift) { shifts(:shift_one) }
  subject(:serializer) do
    JSON.parse(described_class.new(shift).to_json, symbolize_names: true)
  end

  it 'builds the attributes' do
    expect(serializer[:id]).to eq(shift.id)
    expect(serializer[:contract_id]).to eq(shift.contract_id)
    expect(serializer[:date]).to eq(shift.date.iso8601)
    expect(serializer[:day_of_week]).to eq(shift.day_of_week)
    expect(serializer[:start_hour]).to eq(shift.start_hour)
    expect(serializer[:end_hour]).to eq(shift.end_hour)
  end
end
