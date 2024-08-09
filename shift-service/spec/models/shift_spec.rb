# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe 'associations' do
    it { should belong_to(:contract) }
    it { should have_many(:engineer_shifts).dependent(:destroy) }
    it { should have_many(:engineers).through(:engineer_shifts) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:day_of_week) }
    it { should validate_presence_of(:start_hour) }
    it { should validate_presence_of(:end_hour) }
  end

  describe 'scopes' do
    let(:shift1) { shifts(:shift_one) }
    let(:shift2) { shifts(:shift_two) }

    context 'by_date' do
      it 'returns shifts matching the date' do
        expect(Shift.by_date('2024-08-19')).to include(shift1)
        expect(Shift.by_date('2024-08-19')).not_to include(shift2)
      end
    end

    context 'by_contract' do
      let(:contract) { contracts(:base) }
      let(:contract_one) { contracts(:contract_one) }

      it 'returns shifts matching the contract_id' do
        expect(Shift.by_contract(contract.id)).to include(shift1)
        expect(Shift.by_contract(contract.id)).not_to include(contract_one)
      end
    end

    context 'by_day_of_week' do
      it 'returns shifts matching the day_of_week' do
        expect(Shift.by_day_of_week('Monday')).to include(shift1)
        expect(Shift.by_day_of_week('Monday')).not_to include(shift2)
      end
    end
  end
end
