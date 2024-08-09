# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EngineerShiftSerializer, type: :serializer do
  let(:engineer_shift) { engineer_shifts(:one_confirmed) }
  subject(:serializer) do
    JSON.parse(described_class.new(engineer_shift).to_json, symbolize_names: true)
  end

  it 'builds the attributes' do
    expect(serializer[:id]).to eq(engineer_shift.id)
    expect(serializer[:engineer_id]).to eq(engineer_shift.engineer_id)
    expect(serializer[:status]).to eq(engineer_shift.status)
  end
end
