# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shifts::UpdateService, type: :service do
  let(:contract) { contracts(:base) }
  let(:shift) { shifts(:shift_two) }
  let(:engineer) { engineers(:base) }
  let(:another_engineer) { engineers(:three) }
  let(:params) { load_dynamic_json_symbolized('payload/shifts/update.json.erb', engineer_id: engineer.id) }
  let(:service) { described_class.new(shift:, params:) }

  describe '#execute!' do
    it 'updates the shift attributes and saves the shift' do
      service.execute!

      shift.reload
      expect(shift.date.iso8601).to eq('2024-08-20')
      expect(shift.start_hour).to eq('11:00')
      expect(shift.end_hour).to eq('12:00')
    end

    it 'associates the shift with engineers' do
      service.execute!

      shift.reload
      expect(shift.engineer_shifts.count).to eq(1)
      expect(shift.engineer_shifts.first.engineer_id).to eq(engineer.id)
    end

    context 'when the attributes are invalid' do
      before { params[:start_hour] = nil }

      it 'raises an ActiveRecord::RecordInvalid exception' do
        expect { service.execute! }.to raise_exception ActiveRecord::RecordInvalid
      end
    end

    context 'when there is an attempt to confirm multiple engineers' do
      before do
        shift.update!(
          date: Date.parse('2024-08-20'),
          start_hour: '11:00',
          end_hour: '12:00',
          day_of_week: 'Tuesday',
          contract_id: contract.id
        )

        shift.engineer_shifts.create!(engineer_id: engineer.id, status: :confirmed)

        params[:engineer_shifts_attributes] = [
          { engineer_id: another_engineer.id, _destroy: false, status: :confirmed }
        ]
      end

      it 'raises a validation error' do
        expect { service.execute! }.to raise_exception(ActiveRecord::RecordInvalid)
        expect(shift.engineer_shifts.where(status: :confirmed).count).to eq(1)
      end
    end
  end
end
