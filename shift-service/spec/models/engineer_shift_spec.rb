# frozen_string_literal: true

# spec/models/engineer_shift_spec.rb

require 'rails_helper'

RSpec.describe EngineerShift, type: :model do
  describe 'Associations' do
    it { should belong_to(:shift) }
    it { should belong_to(:engineer) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:engineer).scoped_to(:shift_id) }

    context 'when creating a new EngineerShift' do
      it 'is valid with valid attributes' do
        engineer_shift = EngineerShift.new(
          shift: shifts(:shift_one),
          engineer: engineers(:two),
          status: :scheduled
        )
        expect(engineer_shift).to be_valid
      end

      it 'is invalid if there is already a confirmed engineer for the shift' do
        engineer_shift = EngineerShift.new(
          shift: shifts(:shift_one),
          engineer: engineers(:three),
          status: :confirmed
        )
        expect(engineer_shift).to_not be_valid
        expect(engineer_shift.errors[:status]).to include(I18n.t('errors.messages.only_one_confirmed_per_shift'))
      end

      it 'is valid if there is no confirmed engineer for the shift' do
        EngineerShift.create!(
          shift: shifts(:shift_two),
          engineer: engineers(:base),
          status: :scheduled
        )

        engineer_shift = EngineerShift.new(
          shift: shifts(:shift_two),
          engineer: engineers(:two),
          status: :confirmed
        )

        expect(engineer_shift).to be_valid
      end
    end
  end
end
