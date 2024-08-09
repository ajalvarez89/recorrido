# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeRangeValidator do
  subject(:contract) { Contract.new(start_hour_weekday:, end_hour_weekday:, start_hour_weekend:, end_hour_weekend:) }

  before { contract.valid? }

  context 'when start_hour_weekday is before end_hour_weekday' do
    let(:start_hour_weekday) { 9 }
    let(:end_hour_weekday) { 17 }
    let(:start_hour_weekend) { nil }
    let(:end_hour_weekend) { nil }

    it 'does not add errors for weekdays' do
      expect(contract.errors[:start_hour_weekday]).to be_empty
    end
  end

  context 'when start_hour_weekday is after end_hour_weekday' do
    let(:start_hour_weekday) { 17 }
    let(:end_hour_weekday) { 9 }
    let(:start_hour_weekend) { nil }
    let(:end_hour_weekend) { nil }

    it 'adds an error for invalid weekday hours' do
      expect(contract.errors[:start_hour_weekday]).to include I18n.t('errors.messages.invalid_start_hours',
                                                                     period: 'weekdays')
    end
  end

  context 'when start_hour_weekend is before end_hour_weekend' do
    let(:start_hour_weekday) { nil }
    let(:end_hour_weekday) { nil }
    let(:start_hour_weekend) { 10 }
    let(:end_hour_weekend) { 14 }

    it 'does not add errors for weekends' do
      expect(contract.errors[:start_hour_weekend]).to be_empty
    end
  end

  context 'when start_hour_weekend is after end_hour_weekend' do
    let(:start_hour_weekday) { nil }
    let(:end_hour_weekday) { nil }
    let(:start_hour_weekend) { 15 }
    let(:end_hour_weekend) { 10 }

    it 'adds an error for invalid weekend hours' do
      expect(contract.errors[:start_hour_weekend]).to include I18n.t('errors.messages.invalid_start_hours',
                                                                     period: 'weekends')
    end
  end

  context 'when either start_hour or end_hour is nil' do
    let(:start_hour_weekday) { nil }
    let(:end_hour_weekday) { 17 }
    let(:start_hour_weekend) { 10 }
    let(:end_hour_weekend) { nil }

    it 'does not add errors if end_hour_weekend is nil' do
      expect(contract.errors[:start_hour_weekend]).to be_empty
    end
  end
end
