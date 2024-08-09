# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contract, type: :model do
  subject(:contract) { contracts(:base) }

  describe 'Associations' do
    it { should belong_to(:service) }
    it { should have_many(:shifts).dependent(:destroy) }
    it { should have_many(:engineer_shifts).through(:shifts) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }

    it 'validates numericality of' do
      should validate_numericality_of(:start_hour_weekday)
        .only_integer.is_greater_than_or_equal_to(0)
        .is_less_than_or_equal_to(23)
      should validate_numericality_of(:end_hour_weekday)
        .only_integer.is_greater_than_or_equal_to(0)
        .is_less_than_or_equal_to(23)
      should validate_numericality_of(:start_hour_weekend)
        .only_integer.is_greater_than_or_equal_to(0)
        .is_less_than_or_equal_to(23)
      should validate_numericality_of(:end_hour_weekend)
        .only_integer.is_greater_than_or_equal_to(0)
        .is_less_than_or_equal_to(23)
    end
  end

  describe 'Time Range Validations' do
    context 'when start hour is greater than or equal to end hour' do
      it 'adds an error on weekday' do
        contract.start_hour_weekday = 10
        contract.end_hour_weekday = 9
        contract.valid?

        expect(contract.errors[:start_hour_weekday])
          .to include(I18n.t('errors.messages.invalid_start_hours', period: 'weekdays'))
      end

      it 'adds an error on weekend' do
        contract.start_hour_weekend = 20
        contract.end_hour_weekend = 19
        contract.valid?

        expect(contract.errors[:start_hour_weekend])
          .to include(I18n.t('errors.messages.invalid_start_hours', period: 'weekends'))
      end
    end
  end
end
