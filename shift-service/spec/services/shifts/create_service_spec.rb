# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shifts::CreateService, type: :service do
  let(:service_id) { services(:base).id }

  let(:contract) do
    Contract.create!(
      start_date: '2024-08-19',
      end_date: '2024-08-25',
      start_hour_weekday: 9,
      end_hour_weekday: 17,
      start_hour_weekend: 10,
      end_hour_weekend: 14,
      service_id:
    )
  end

  let(:params) { { id: contract.id } }
  let(:service) { described_class.new(params) }

  describe '#execute!' do
    it 'creates shifts for each day in the contract date range' do
      expect { service.execute! }.to change(Shift, :count).by(48)

      shifts = Shift.where(contract_id: contract.id).order(:date, :start_hour)

      expect(shifts.count).to eq(48)
      expect(shifts.first.date).to eq(Date.parse('2024-08-19'))
      expect(shifts.last.date).to eq(Date.parse('2024-08-25'))
    end

    it 'creates shifts with correct attributes' do
      service.execute!

      shifts = Shift.where(contract_id: contract.id)

      weekday_shifts = shifts.select { |shift| shift.day_of_week.in?(%w[Monday Tuesday Wednesday Thursday Friday]) }
      weekend_shifts = shifts.select { |shift| shift.day_of_week.in?(%w[Saturday Sunday]) }

      expect(weekday_shifts.size).to eq(40)
      expect(weekend_shifts.size).to eq(8)

      expect(weekday_shifts.first.start_hour).to eq('09:00')
      expect(weekday_shifts.first.end_hour).to eq('10:00')
      expect(weekday_shifts.last.start_hour).to eq('16:00')
      expect(weekday_shifts.last.end_hour).to eq('17:00')

      expect(weekend_shifts.first.start_hour).to eq('10:00')
      expect(weekend_shifts.first.end_hour).to eq('11:00')
    end

    context 'when the start_date is not a Monday' do
      let(:invalid_contract) do
        Contract.create!(
          start_date: '2024-08-20', # Tuesday
          end_date: '2024-08-25',
          start_hour_weekday: 9,
          end_hour_weekday: 17,
          start_hour_weekend: 10,
          end_hour_weekend: 14,
          service_id:
        )
      end

      let(:invalid_service) { described_class.new(id: invalid_contract.id) }

      it 'raises an error' do
        expect { invalid_service.execute! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
